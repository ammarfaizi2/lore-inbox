Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311237AbSCLPZs>; Tue, 12 Mar 2002 10:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311236AbSCLPZi>; Tue, 12 Mar 2002 10:25:38 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:14345 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S311235AbSCLPZb>; Tue, 12 Mar 2002 10:25:31 -0500
Date: Tue, 12 Mar 2002 15:20:24 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx: Slow negotiation? 
In-Reply-To: <200203111435.g2BEZYI09079@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.33.0203121519250.18363-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Justin T. Gibbs wrote:

> >The new aic7xxx driver (in 2.4.17, 2.5.1-pre1 and 2.5.6, at
> >least) negotiates only 11.626MB/s transfers from my disks.
> >The old one can extract 40MB/s transfers (though the disks
> >themselves can only do a little over 20MB/s each).
>
> Go into SCSI-Select and change all of the sync rate values to
> something other than you want.  Save the changes.  Reboot.  Go back
> into SCSI-Select and change the sync values to what you want. The
> driver will then recognize them.

Worked a treat, thanks very much.

> Some MB manufacturers using the aic7895 screwed up the initialation of
> the serial eeprom while they were assembling their boards.  The old
> driver tries to work around this, but the work-around means converting
> one of the lower sync rates into meaning "full speed". I decided that
> just wasn't safe to put in the new driver.

Is a warning printk() possible?

Cheers,
Matthew.

