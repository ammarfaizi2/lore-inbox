Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVBPWPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVBPWPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 17:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVBPWPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 17:15:07 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:41310 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262102AbVBPWPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 17:15:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dvj+Vi79UwwkYBZQMWrEP1LmMeVLDdeFjdcijHfF7qJkSD6SFlZXGTH4C2IA01cZL2Dg+72/WKSlbg1tMTSwVbgbDAWoXCSYN8Hr4ofFQ8tQ6/9B4FDqjwMRbm2rznxyY2SpqOa4ZdJmM1PwgtPHAJfSR05OzSIHxe5UKSw2/Mw=
Message-ID: <5b64f7f05021614153eed0536@mail.gmail.com>
Date: Wed, 16 Feb 2005 17:15:01 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: govind raj <agovinda04@hotmail.com>
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
In-Reply-To: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <52vf8sw6no.fsf@topspin.com>
	 <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The GRUB detects the CF hard disk as
> hda0 when we boot the embedded board and so in both the kernel parameter in
> grub.conf as well as in the inittab file we have / (root) marked as
> /dev/hda0.

Grub and the kernel number things differently. In particular, grub
numbers partitions starting at 0, while the kernel starts at 1. So
while you would use "root (hd0,0" for grub, the kernel commandline
would be "root=/dev/hda1".

Hope this helps,
Rahul
