Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271586AbVBEPuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271586AbVBEPuO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 10:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbVBEPuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 10:50:14 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:30588 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271586AbVBEPt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 10:49:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=G1/RrbigcwDJkZmuNDEfQICJHB3XgutEwyMVNIp2aP+PWhIKNGloCFhE1BE04+ATpon0OWLg+PnIM+UofwZsH6P3CvnWPAexEvFFj/3csoNCoqWBPVHmiaesbd+e+mp09pRMARUQUOvGyLadxMH6pK/f8PG5eQm1Wc1+ugnvhDA=
Message-ID: <9e47339105020507494846bc4d@mail.gmail.com>
Date: Sat, 5 Feb 2005 10:49:52 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
In-Reply-To: <20050205093740.GD1158@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e796392205020221387d4d8562@mail.gmail.com>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
	 <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <20050205093740.GD1158@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Feb 2005 10:37:40 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> > > I do not understand how initramfs fits into picture... Plus lot of
> > > people (me :-) do not use initramfs...
> >
> > The final fix for this will include the video reset app on initramfs.
> > I already have code in the kernel for telling the primary video card
> > from secondary ones. When the kernel is initially booting and finds
> 
> Is initramfs preserved when system is running? I was under impression
> that it is freed when we mount real / fs.

It doesn't matter if it is mounted or unmounted. The reset program is
just an app and another copy can live in /sbin. It's only on initrams
so that it can initial the video during early boot allowing you to see
error messages at that stage.

-- 
Jon Smirl
jonsmirl@gmail.com
