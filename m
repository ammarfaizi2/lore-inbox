Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTHCX51 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 19:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTHCX51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 19:57:27 -0400
Received: from waste.org ([209.173.204.2]:33428 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S271331AbTHCX50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 19:57:26 -0400
Date: Sun, 3 Aug 2003 18:57:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: Heikki Tuuri <Heikki.Tuuri@innodb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-ID: <20030803235723.GX22824@waste.org>
References: <004601c359e0$9f905ad0$322bde50@koticompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004601c359e0$9f905ad0$322bde50@koticompaq>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 07:59:37PM +0300, Heikki Tuuri wrote:
> Shane,
> 
> "
> | tv01.program     | check | error    | got error: 5 when reading datafile
> at record: 6696 |
> "
> 
> InnoDB reported that same error 5 "EIO I/O error" in a call of fsync().
> MyISAM never calls fsync(), but I guess these problems are related. Let us
> hope Andrew's fix fixes this MyISAM problem, too.

Andrew introduced a buglet to my sync fixes -mm3 that reported IO
errors on any sync(). The logic in -mm3-1 should fix this and actually
report failed syncs.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
