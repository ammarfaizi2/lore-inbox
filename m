Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132117AbRAPQlU>; Tue, 16 Jan 2001 11:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRAPQlL>; Tue, 16 Jan 2001 11:41:11 -0500
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:28123 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S132108AbRAPQk7>; Tue, 16 Jan 2001 11:40:59 -0500
Date: Tue, 16 Jan 2001 17:40:09 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Venkatesh Ramamurthy <Venkateshr@ami.com>
Cc: "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010116174009.B12251@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Venkatesh Ramamurthy <Venkateshr@ami.com>,
	'David Woodhouse' <dwmw2@infradead.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518D@ATL_MS1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E9518D@ATL_MS1>; from Venkateshr@ami.com on Tue, Jan 16, 2001 at 11:19:34AM -0500
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 11:19:34AM -0500, Venkatesh Ramamurthy wrote:
> > It should be possible to read the BIOS setting for this option and
> > behave accordingly. Please give full details of how to read and interpret
> > the information stored in the CMOS for all versions of AMI BIOS, and I'll
> > take a look at this.
> 	[Venkatesh Ramamurthy]  When i meant BIOS setting option i meant the
> SCSI BIOS settings not system BIOS option. The two SCSI controllers are of
> different make. This situation is made worse when the system has many cards
> of different makes and one of the controller somewhere in the middle of all
> the slots is made the boot controller. 

This is due to the fixed ordering of the scsi drivers. You can change the
order of the scsi hosts with the "scsihosts" kernel parameter. See
linux/drivers/scsi/scsi.c

Yours,
  Dominik
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
http://petition.lugs.ch/ (in Switzerland)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
