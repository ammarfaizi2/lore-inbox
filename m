Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270479AbTGXD0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 23:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270480AbTGXD0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 23:26:00 -0400
Received: from tantale.fifi.org ([216.27.190.146]:56971 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S270479AbTGXDZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 23:25:58 -0400
To: Vinnie <listacct1@lvwnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 (and newer) - prob with the new adaptec aic7xxx driver and Promise UltraTrak100 TX2
References: <3F1F5397.8000001@lvwnet.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 23 Jul 2003 20:41:02 -0700
In-Reply-To: <3F1F5397.8000001@lvwnet.com>
Message-ID: <87ispsd229.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinnie <listacct1@lvwnet.com> writes:

> Hello everyone,
> 
> Yep, I know... 2.4.19 is old news.  But I have tried this with newer
> official kernels also, same results.  Not expecting anybody to have a
> quick fix (although any suggestions would be really welcome!), but I
> do feel that this should be reported, since I have not seen many other
> posts indicating problems like this with "the new adaptec drivers".
> 
> Our primary file server is a dual 1.4GHz Tualatin 512K machine, with a
> Tyan S2688 Serverworks HE-SLt mainboard, 2GB of registered ECC SDRAM
> (4x512 modules), which also has an AIC7899 dual channel U160 host
> adapter onboard.
> 
> The only SCSI device currently attached is a Promise UltraTrak100 TX8
> - an 8-bay SCSI-to-ATA RAID subsystem, with eight 120GB Western
> Digital drives configured as a 7-drive RAID5 array and 1 non-assigned
> hot spare.  The unit's SCSI interface can run 80MB/sec U2W/LVD (and
> unit's SCSI ID is configured appropriately in the HA BIOS.  The
> internal ribbon cable from motherboard to external connector is a
> custom-made Granite Digital teflon cable, and I am also using a
> Granite Digital Active Terminator to terminate the bus (at the TX8).
> Using the external cable supplied by Promise with the unit.
> 
> Note: Problem is reproducible with an Adaptec AHA-2940U2W used as the
> host adapter instead.
> 
> In a nutshell, the problem goes like this:
> 
> If I compile the kernel to use the NEW aic7xxx adaptec driver, the
> SCSI bus hangs almost immediately upon commencement of a large write
> operation, such as attempting to copy a 500MB file from one of the
> internal client machines to a SMB shared directory on this server.
> The problem is reproducible on 2.4.19 and 2.4.20 kernels, if I use the
> "new" aic7xxx driver.

8< snip >8

Have you tried the updated aic7xxx driver at
http://people.freebsd.org/~gibbs/linux/SRC/ ?

AFAIK it fixes a lot of problems with aic7xxx and was not included in
2.4.21 for technicalities.

Phil.
