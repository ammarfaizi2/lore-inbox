Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264315AbTIITrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbTIITrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:47:41 -0400
Received: from waste.org ([209.173.204.2]:63186 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264315AbTIITrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:47:31 -0400
Date: Tue, 9 Sep 2003 14:47:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sleeping function called from invalid context
Message-ID: <20030909194727.GI31897@waste.org>
References: <3F5DEBA5.9060607@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5DEBA5.9060607@rackable.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 08:03:01AM -0700, Samuel Flory wrote:
>  I'm seeing this on arjanv's 2.6.0-0.test4.1.33 kernel.

> Debug: sleeping function called from invalid context at 
> include/asm/uaccess.h:473
> Call Trace:
> [<c011b7dd>] __might_sleep+0x5d/0x70
> [<c010d0ea>] save_v86_state+0x6a/0x200

It's a warning about the possibility of hitting a very old but rarely
hit bug, system should work the same as it always has despite the
warning. I'm working on this, but it's ugly. Hope to post a patch in
the next week or so.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
