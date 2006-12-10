Return-Path: <linux-kernel-owner+w=401wt.eu-S933385AbWLJVbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWLJVbP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933568AbWLJVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:31:15 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:58073 "EHLO gaz.sfgoth.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933385AbWLJVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:31:14 -0500
Date: Sun, 10 Dec 2006 13:49:34 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Folkert van Heusden <folkert@vanheusden.com>, linux-kernel@vger.kernel.org
Subject: Re: strncpy optimalisation? (lib/string.c)
Message-ID: <20061210214934.GC47959@gaz.sfgoth.com>
References: <20061210205230.GB30197@vanheusden.com> <20061210210614.GD24090@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210210614.GD24090@1wt.eu>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sun, 10 Dec 2006 13:49:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Original code completely pads the destination with zeroes,
> while yours only adds the last zero. Your code does what
> strncpy() is said to do, but maybe there's a particular
> reason for it to behave differently in the kernel

No, the kernel's strncpy() behaves the same as the one in libc.  Run
"man strncpy" if you don't believe me.

In the common case where you just want to copy a string and avoid
overflow use strlcpy() instead

-Mitch
