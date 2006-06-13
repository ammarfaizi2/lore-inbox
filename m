Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWFMQU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFMQU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWFMQU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:20:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:11225 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932168AbWFMQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:20:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ddhPiGOaZgeEl6fd0+vDZt4mwe3OlJ1BbioK55JnGLuvh/gt7DMKzb1v4/LsdT2gp1UkYuY9ui18FvrU4XpKuRmqAs2VnVRjK1CDhKWUtYNiddF69zJpqToxwpwqJ4qdxrPuRc/+2Fgq7hi6o+7vJ4fTzdUYHdy2emvqPe9BXvM=
Message-ID: <305c16960606130920wa66c6bk504273a9a45e645e@mail.gmail.com>
Date: Tue, 13 Jun 2006 13:20:55 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: How does RAID work with IT8212 RAID PCI card?
Cc: "Christian H?rtwig" <christian.haertwig@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060613160138.GC560@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606131758.45704.christian.haertwig@gmx.de>
	 <20060613160138.GC560@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Tue, Jun 13, 2006 at 05:58:45PM +0200, Christian H?rtwig wrote:
> > i need some advise regarding the usage of the above kernel module. Today i
> > have plugged a PCI RAID card into my computer, IT8212 chip on it, and two
> > identical hard drives on the primary and secondary master of that controller.
> > In the controller BIOS i defined a mirror set out of those both disks and
> > booted linux afterwards.
> >
> > Loading the kernel module dmesg showed that the controller was found and that
> > 2 harddiscs are attached to it.
> >
> > The thing that i wonder about is, that i still can "see" both harddisks
> > independently, but i would expect to see only one harddisk at all, that
> > represents the RAID set. Udev also registers /dev/hde and /dev/hdg, but (as
> > far as i can see) no further device.
> >
> > Is there anything wrong about my setup? Is this i driver issue? Or is this the
> > normal and expected behaviour and its me who doesn't "use" the module
> > properly? How to i access the RAID set instead of the two seperate disks?
>
> Congratulations.  You have a fake raid card by the sound of it.  A
> hardware raid card would have only shown one drive, while a fake raid
> card expects the driver to work with the bios to find out the setup (and
> handle booting), and then the driver does all the raid work in software.
>
> It is much simpler to treat fake raid cards as just another drive
> controller and use linux software raid on it.  At least then you know
> how it works, and it is portable to other controllers later if needed.
>
> Len Sorensen
> -

No not true, i have this card and its a true hardware raid card. The
thing is, this card has both a raid and a passthru mode, you should
check which bios is flashed into it. Google is your friend.
