Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVBYCBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVBYCBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 21:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVBYCBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 21:01:55 -0500
Received: from gw.goop.org ([64.81.55.164]:29641 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262579AbVBYCBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 21:01:54 -0500
Message-ID: <421E8708.9090802@goop.org>
Date: Thu, 24 Feb 2005 18:01:44 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] override RLIMIT_SIGPENDING for non-RT signals
References: <200502240145.j1O1jlab010606@magilla.sf.frob.com>
In-Reply-To: <200502240145.j1O1jlab010606@magilla.sf.frob.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:

>Indeed, I think your patch does not go far enough.  I can read POSIX to say
>that the siginfo_t data must be available when `kill' was used, as well.
>This patch makes it allocate the siginfo_t, even when that exceeds
>{RLIMIT_SIGPENDING}, for any non-RT signal (< SIGRTMIN) not sent by
>sigqueue (actually, any signal that couldn't have been faked by a sigqueue
>call).
>
Looks OK to me.  I'll give this a try soon.

    J
