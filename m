Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVECVms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVECVms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVECVms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 17:42:48 -0400
Received: from mail.microway.com ([64.80.227.22]:3989 "EHLO mail.microway.com")
	by vger.kernel.org with ESMTP id S261806AbVECVmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 17:42:45 -0400
From: Rick Warner <rick@microway.com>
Organization: Microway, Inc.
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: zImage on 2.6?
Date: Tue, 3 May 2005 17:42:40 -0400
User-Agent: KMail/1.7.2
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com> <20050503164012.GE11937@animx.eu.org>
In-Reply-To: <20050503164012.GE11937@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <200505031742.40554.rick@microway.com>
X-Sanitizer: Advosys mail filter
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 May 2005 12:40 pm, Wakko Warner wrote:
> Please keep me CCd
>
> Rick Warner wrote:
> > On Monday 02 May 2005 09:29 pm, Wakko Warner wrote:
> > > Is it possible to use zImage on 2.6 kernels or is bzImage required?
> >
> > Why do you need the zImage anyway?  Maybe there is another way around the
> > problem you are having.  Can you post what you are trying to do (end
> > goal) ?
>
> This is a little project I'm doing to beable to load a system onto a hard
> drive.  The linux system is short lived by design and will run out of a
> tmpfs root populated by various tgz files found either on CDs or a USB
> stick.
>
> My goal (which I realize may not be achivable nor is it important in the
> long run) is to get the kernel and the initrd onto a single floppy disk
> (Currently, I'm ~80kb too large for this).
>
> I decided (remembering 2.2 days and prior when zImage was normally used) to
> try zImage to see what happened.  I was going to compare the size of the
> resulting images.  That's when I hit the problem.
>
> I understand that upx can compress the kernel better and I also remember
> hearing about utilizing bzip2 as the compressor for the kernel and initrd
> images.
>
> As far as my question, it still stands.  Is bzImage required (i386/x86) for
> a 2.6 kernel?

As others have mentioned, bzImage seems to be a requirement now for x86.  
However, zImage will not do any better for you.  I recall doing testing of 
zImage vs bzImage a long time back, and the bzImage kernels were slightly 
smaller than the zImage ones anyway.  I think you're going to be out of luck 
trying to get your kernel that small.  A single floppy boot/root disk isn't 
really possible with 2.6 kernels anymore.  Have you looked into pxe booting 
instead?  I work at a cluster company and we do tons of pxe/network booting 
stuff.

-- 
Richard Warner
Lead Systems Integrator
Microway, Inc
(508)732-5517
