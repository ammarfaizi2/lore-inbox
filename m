Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWBJGDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWBJGDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWBJGDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:03:34 -0500
Received: from web50212.mail.yahoo.com ([206.190.39.176]:52846 "HELO
	web50212.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751153AbWBJGDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:03:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wJMb/QXO9sPstfmE1fXsPf+haWf8QMz5o0HNQYLYXQ36Ndm8U2Xzs5116n83ojzzdduHulm56CvWbtJ+hwLqxjQ6/Ko95qKcRx19j8QdBbP4s05uuI63t7DcCmWgviwmLY24qST1te6Ii4lH/RInrfxJAwShojDNE79ZvrYmhTw=  ;
Message-ID: <20060210060333.8628.qmail@web50212.mail.yahoo.com>
Date: Thu, 9 Feb 2006 22:03:33 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Let's get rid of  ide-scsi
To: Wakko Warner <wakko@animx.eu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060210003614.GA26114@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Wakko Warner <wakko@animx.eu.org> wrote:

> Alex Davis wrote:
> > I think we should get rid of ide-scsi.
> > 
> > Reasons:
> > 1) It's broken.
> > 2) It's unmaintained.
> > 3) It's unneeded.
> > 
> > I'll submit a patch if people agree.
> > 
> > I code, therefore I am
> 
> I personally do not agree with this.  I worked on at boot disk(floppy) which
> contained the kernel and modules to find a cdrom (or usb disk) and use it as
> my 2nd stage.  If I had to use ide-cd, I would not beable to do my first
> stage loader on a single floppy (I support ide and scsi cdroms via sr-mod).
> 
> ide-cd.ko is > than sr-mod.ko + ide-scsi.ko
> 
> I am aware that scsi_mod.ko is larger than those 3 combined and I still need
> it regardless for usb.
> 
> My personal vote would be to drop the entire ide subsystem which would thus
> drop ide-scsi.  The SCSI layer has been a general block device layer for
> more than true scsi devices.  USB, Firewire, and SATA use the scsi layer. 
> And as I understand it, libata is starting to handle PATA devices.  Once it
> can handle PATA fine, the ide code would pretty much be useless.
> 
> I am also against the seperate USB block layer, I personally saw no use in
> it.
> 
> -- 
>  Lab tests show that use of micro$oft causes cancer in lab animals
>  Got Gas???
> 

Wakko:

Modules can be compressed: On a 2.6.15 kernel doing a 'gzip -9 idecd.ko' reduced its size
from 43616 bytes to 19234 bytes. The only additional step is modifying 'modules.dep' and
changing idecd.ko to idecd.ko.gz. You now have a fully functional ide cdrom driver.



I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
