Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272135AbRHVVyI>; Wed, 22 Aug 2001 17:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272137AbRHVVx6>; Wed, 22 Aug 2001 17:53:58 -0400
Received: from femail41.sdc1.sfba.home.com ([24.254.60.35]:9209 "EHLO
	femail41.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272135AbRHVVxr>; Wed, 22 Aug 2001 17:53:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mikpe@csd.uu.se (Mikael Pettersson)
Subject: Re: [PATCH,RFC] make ide-scsi more selective
Date: Wed, 22 Aug 2001 14:53:23 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        ionut@cs.columbia.edu
In-Reply-To: <E15ZfNZ-0002J3-00@the-village.bc.nu>
In-Reply-To: <E15ZfNZ-0002J3-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01082214532302.00394@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 August 2001 02:17 pm, Alan Cox wrote:
> > I've been rather annoyed by a dual problem in the ide-scsi setup:
> > during initialisation, ide-scsi will claim ALL currently unassigned
> > IDE devices. This is a problem in modular setups, since there's
> > no guarantee that currently unassigned devices actually are intended
> > for ide-scsi.
>
> The real problem is that the drivers are claiming resources on load not
> on open. Why shouldnt I be able to load ide-cd and ide-scsi and open
> either /dev/hda or /dev/sr0 but not both together ?

Here's an end-user perspective for you... I just spent 2 days trying to 
figure out how to use my CD-RW drive to read when using ide-scsi, before 
I finnaly realized that I had to do it by disabling ATAPI CD support and 
enabling SCSI CD support..
This is a severe inconvienience to the end-user who doesn't know what the 
problem is, esspecialy since I only found the answer to the problem in a 
couple places, I had to go through a ton of google search results to find 
anything.
