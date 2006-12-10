Return-Path: <linux-kernel-owner+w=401wt.eu-S933843AbWLJVgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933843AbWLJVgj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933840AbWLJVgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:36:38 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:58121 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933843AbWLJVgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:36:37 -0500
Date: Sun, 10 Dec 2006 13:55:04 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
Message-ID: <20061210215504.GD47959@gaz.sfgoth.com>
References: <20061210212350.GC30197@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210212350.GC30197@vanheusden.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sun, 10 Dec 2006 13:55:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> Like the other patch (by that other person), I think it is faster to not
> do a strlen first.

Debatable.  You've replaced a call to the highly-optimized memcpy function
with a byte-by-byte copy.  It's probably a wash performance wise (have you
benchmarked?) and is certainly less clear.

-Mitch
