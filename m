Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRKNScI>; Wed, 14 Nov 2001 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRKNSb6>; Wed, 14 Nov 2001 13:31:58 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27140
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S273305AbRKNSbs> convert rfc822-to-8bit; Wed, 14 Nov 2001 13:31:48 -0500
Date: Wed, 14 Nov 2001 10:31:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: linux readahead setting?
In-Reply-To: <200111140038.fAE0ctq11703@mailg.telia.com>
Message-ID: <Pine.LNX.4.10.10111141026320.1247-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Roger Larsson wrote:

> On Tuesday 13 November 2001 16:21, Roy Sigurd Karlsbakk wrote:
> > Hi
> >
> > I heard linux does <= 32 page readahead from block devices
> > (scsi/ide/que?). Is there a way to double this? I want to read 256kB
> > chunks from the SCSI drives, as to get the best speed. These numbers are
> > based on some testing and information I've got from Compaq's storage guys.
> >
> > roy
> 
> Note that the interface to /proc/ide/hdX/settings still is buggy...
> 
> i.e you should be able to do (in pages):
> echo "file_readahead:64" > /proc/ide/hdX/settings
> but the result will be a readahead of 128*1024 PAGES... and that
> is too much... (even 1024 PAGES is too much)
> 
> (after patch, in kB)
> echo "file_readahead:256" > /proc/ide/hdX/settings
> 
> It is likely that there are more settings in the ide subsystem that is
> has this fault... (Andre, I keep repeating myself...)
> 
> /RogerL
> -- 
> Roger Larsson
> Skellefteå
> Sweden

It is hard to reply when your ISP rotates/changes its total block of
assigned IP address, while still not being able to update or fix dns
records at netsol to operate correctly.

And if you set the value of any given settings value large than its top
boundary it would most likely wrap.  Right now it appears that a readahead
patch that I was looking may have borked performance.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

