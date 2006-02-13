Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWBMRtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWBMRtu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWBMRtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:49:50 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:54961 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932378AbWBMRtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:49:49 -0500
From: Luke-Jr <luke@dashjr.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 17:49:43 +0000
User-Agent: KMail/1.9
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
References: <43EB7BBA.nailIFG412CGY@burner> <200602131722.29633.luke@dashjr.org> <43F0C4A3.nailMEM11MHR7@burner>
In-Reply-To: <43F0C4A3.nailMEM11MHR7@burner>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131749.46880.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 17:40, Joerg Schilling wrote:
> Luke-Jr <luke@dashjr.org> wrote:
> > > I mentioned:
> > >
> > > -	ide-scsi does not do DMA correctly
> >
> > IIRC, ide-scsi is deprecated and would be removed as a fix for this bug.
> > Note that ide-scsi is known to be broken in more ways than just this--
> > for example, unloading the module causes a kernel panic.
>
> A last word on that:
>
> -	this bug is known for more than 2 years.
>
> -	time to fix: less than 3 hours for the right person
>
> -	I therefore expect a fix in less than a month or
> 	I must asume that Linux is not longer actively maintained.

What does it do "wrong" anyway? IIRC, DMA in general works...
Also note that since SCSI does not support DMA, I wouldn't consider lack of 
DMA for ide-scsi a bug. Just because the underlying device is IDE and has DMA 
support doesn't mean that the SCSI layer (which has no reason for DMA) should 
use it.
