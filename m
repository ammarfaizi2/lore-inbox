Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbVBQRa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVBQRa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVBQRa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:30:58 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:52382 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262311AbVBQRaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:30:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=K/YN26UF1UGuWzS5rhB6W/1hPRID0tQp1KBAbQIdZ3Ow/tM8InoFoObZ82isUTNagfwWQwcsAVdVu69TlAXEyOo2RgSTNyN601ZkTdbnfoBGacHNsFDGRKxtcMCswOkp1LHWYhXur1zTc4wc0SxJ7EdPpcS1Cj8vv0q+qi+OjJk=
Message-ID: <d120d5000502170930ccc3e9e@mail.gmail.com>
Date: Thu, 17 Feb 2005 12:30:50 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: John M Flinchbaugh <john@hjsoft.com>
Subject: Re: Swsusp, resume and kernel versions
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050217162847.GA32488@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502162346.26143.dtor_core@ameritech.net>
	 <20050217110731.GE1353@elf.ucw.cz>
	 <20050217162847.GA32488@butterfly.hjsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 11:28:47 -0500, John M Flinchbaugh <john@hjsoft.com> wrote:
> On Thu, Feb 17, 2005 at 12:07:31PM +0100, Pavel Machek wrote:
> > When all the vendor's kernels have swsusp, it will magically kill the
> > signature. Or stick mkswap /dev/XXX in your init scripts.
> 
> This is what I've done in some instances.  There should be no harm in
> sticking that mkswap into your init scripts right before the swapon -a,
> and then you have a nice userspace solution.
> 
> It's safe to reinitialize swap on any clean boot.  A resume will not get
> into the init scripts.
> 
> Just remember you're doing the mkswap if you decide to rearrange your
> partitions at all, or code a script smart enough to grep your swap
> partitions out of your fstab.

It could be a workaround. Still it will cause loss of unsaved work if
I happen to load wrong kernel. Given that the code checking for swsusp
image can be marked __init I don't understand the reasons gainst doing
it.

-- 
Dmitry
