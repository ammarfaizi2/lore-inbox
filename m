Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265495AbUFSLS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265495AbUFSLS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 07:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUFSLS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 07:18:28 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:6273 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S265495AbUFSLS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 07:18:26 -0400
Subject: Re: [PATCH] Stop printk printing non-printable chars
From: David Woodhouse <dwmw2@infradead.org>
To: matthew-lkml@newtoncomputing.co.uk
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20040618205355.GA5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
Content-Type: text/plain
Message-Id: <1087643904.5494.7.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 19 Jun 2004 12:18:24 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 21:53 +0100, matthew-lkml@newtoncomputing.co.uk
wrote:
> The main problem seems to be in ACPI, but I don't see any reason for
> printk to even consider printing _any_ non-printable characters at all.
> It makes all characters out of the range 32..126 (except for newline)
> print as a '?'.

Please don't do that -- it makes printing UTF-8 impossible. While I'd
not argue that now is the time to start outputting UTF-8 all over the
place, I wouldn't accept that it's a good time to _prevent_ it either,
as your patch would do.

If you want to post-process printk output, don't do it in the kernel. 

I'd suggest that in this instance you should be fixing the ACPI code
instead, so it doesn't print the characters to which you object.

-- 
dwmw2


