Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285338AbSAPRyq>; Wed, 16 Jan 2002 12:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285352AbSAPRyg>; Wed, 16 Jan 2002 12:54:36 -0500
Received: from aldebaran.sra.com ([163.252.31.31]:20190 "EHLO
	aldebaran.sra.com") by vger.kernel.org with ESMTP
	id <S284902AbSAPRyY>; Wed, 16 Jan 2002 12:54:24 -0500
From: David Garfield <garfield@irving.iisd.sra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15429.48638.96256.842851@irving.iisd.sra.com>
Date: Wed, 16 Jan 2002 12:53:02 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
In-Reply-To: <a22nc0$2fh$1@cesium.transmeta.com>
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com>
	<a22nc0$2fh$1@cesium.transmeta.com>
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Followup to:  <15428.47094.435181.278715@irving.iisd.sra.com>
 > By author:    David Garfield <garfield@irving.iisd.sra.com>
 > In newsgroup: linux.dev.kernel
 > >
 > > Hearing all this talk about initramfs and eliminating hardwired
 > > drivers, it occurs to me to ask:
 > > 
 > > Can/will the initramfs mechanism be made to implicitly load into the
 > > kernel the modules (or some of the modules) in the image?
 > > 
 > 
 > No.  The bulk of the work of module loading is the job for insmod.

Agreed.  However, this work could easily be performed by an insmod
variant that takes a module, a "System.map", and a kernel image, and
produces a cpio file as output instead of passing the data to the
kernel for immediate processing.  The kernel mechanism would then only
need to unpack the pieces, relocate, and make the system calls.
