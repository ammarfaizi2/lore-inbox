Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270490AbRHNHnV>; Tue, 14 Aug 2001 03:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270492AbRHNHnM>; Tue, 14 Aug 2001 03:43:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19059 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270490AbRHNHnC>; Tue, 14 Aug 2001 03:43:02 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
In-Reply-To: <15667.997712990@ocs3.ocs-net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2001 01:36:13 -0600
In-Reply-To: <15667.997712990@ocs3.ocs-net>
Message-ID: <m11ymfqej6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

> On Mon, 13 Aug 2001 14:05:05 +0200 (CEST), 
> Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:
> > A good solution would be to have the kernel being two (or three) GZIP
> > files concatenated, the first would be the real-mode code to setup
> > the structure only, the second would be the protected-mode code of the
> > kernel (and the third the initrd). The first part would be a position
> > independant function getting some parameters (address/max size of the
> > structure to fill in) and returning information like microprocessor
> > minimum requirement, video mode supported (number of BPP, or text only),
> > address the kernel has been linked (to load a kernel at 16 Mb), ...
> 
> Before you go too far, there is already an standard for boot loading,
> EFI (Extensible Firmware Interface).  Originally from Intel but it is
> open.  http://developer.intel.com/technology/efi.  IA64 uses this and
> nothing but this, it already loads kernels in ELF format.  There is no
> point in inventing yet another boot interface, unless you cannot do
> what you want in EFI.

Well unless someone removes the architecture specific assumptions of EFI,
and gets it going on every platform there certainly is.  Besides the
fact that despite a complete rewrite the current EFI BIOSes are the
slowest I have seen.  With linuxBIOS I can load a kernel image over
the network before my hard drives spin up to speed.  This isn't always
the right thing to do.  But waiting 45 seconds before you start
booting your operating system is equally insane.

Any bootloader interface that requires a callback for more then a
fatal abort of the loaded image will be misimplemented someday.  Even
on the alpha with it's small selection of Firmware this problem
persists.  So the interface to the firmware needs to be as trivially
simple as possible.

Eric

