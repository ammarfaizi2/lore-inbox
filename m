Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRDLUgg>; Thu, 12 Apr 2001 16:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135317AbRDLUgQ>; Thu, 12 Apr 2001 16:36:16 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:63501 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S135315AbRDLUgK>; Thu, 12 Apr 2001 16:36:10 -0400
Message-Id: <200104122036.f3CKa1s70637@aslan.scsiguy.com>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: new aic7xxx driver problems 
In-Reply-To: Your message of "Thu, 12 Apr 2001 22:09:24 +0200."
             <3AD60B74.87A9C6D0@denise.shiny.it> 
Date: Thu, 12 Apr 2001 14:36:01 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can you elaborate on what you had to modify ?
>
>I just added AHC_ULTRA to the features of 7850
>
>AHC_AIC7850_FE	= AHC_SPIOCAP|AHC_AUTOPAUSE|AHC_TARGETMODE|AHC_ULTRA,
>                                                          ^^^^^^^^^^

What's the PCI id of the card you are using?

>Plain v6.1.11 hangs. It prints scsi0: blah blah scsi1: sdfdfgsg, I hear the cd
>spinning up and nothing more.

Did you apply a patch, or upgrade using the tar file?  If the latter,
you're missing some changes to the SCSI layer that make the initial
bus settle delay implimentation more sane.

--
Justin
