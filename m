Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVBOD6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVBOD6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVBOD6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:58:16 -0500
Received: from a213-22-240-12.netcabo.pt ([213.22.240.12]:24960 "EHLO
	sergiomb.no-ip.org") by vger.kernel.org with ESMTP id S261616AbVBOD6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:58:13 -0500
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov
X-Antivirus-bastov: 1.24-st-qms (Clear:RC:1(192.168.1.2):. Processed in 0.331276 secs Process 7768)
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and
	give	dev=/dev/hdX as device
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42115DA2.6070500@osdl.org>
References: <1108426832.5015.4.camel@bastov>
	 <1108434128.5491.8.camel@bastov>  <42115DA2.6070500@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 15 Feb 2005 03:58:00 +0000
Message-Id: <1108439881.5308.12.camel@bastov>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, don't feel much better but thanks a lot!

in conclusion ? 
1- hdc=ide-scsi, now should be hdc=ide-cd for general cd-writer, because
cdrecorder don't need scsi emulation anymore.

2- as hdc already is ide-cd by default, therefore is not necessary to
write it and what should be made is erase the line hdc=ide-scsi.

Correct ?
 

On Mon, 2005-02-14 at 18:25 -0800, Randy.Dunlap wrote:
> Sergio Monteiro Basto wrote:
> > "Use ide-cd and give dev=/dev/hdX as device" 
> > cracks me up , Can someone translate this to English ?
> 
> I'll try.
> It means:  don't use the ide-scsi driver.  Support for it is
> lagging (not well-maintained) because it's really not needed for
> burning CDs.  Just use the ide-cd driver (module) and
> specify the CD burner device as /dev/hdX.
> 
> Example with cdrecord:
> deprecated:
> cdrecord -dev=1,0,0 -data backup.iso
> modern :)
> cdrecord -dev=/dev/hdc -data backup.iso
> 
> Do you know how to _not_ use ide-scsi?  Don't load the module
> if you have it built as a module, or don't build it into the
> kernel boot image.  Mostly don't try to open /dev/sdX, just use
> /dev/hdX instead.
> 
> Hope you feel better soon.
> 

-- 
Sérgio M.B.

