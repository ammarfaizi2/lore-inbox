Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310124AbSCKOd7>; Mon, 11 Mar 2002 09:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310130AbSCKOdt>; Mon, 11 Mar 2002 09:33:49 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:9732 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S310128AbSCKOdi>; Mon, 11 Mar 2002 09:33:38 -0500
Message-Id: <200203111435.g2BEZYI09079@aslan.scsiguy.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx: Slow negotiation? 
In-Reply-To: Your message of "Mon, 11 Mar 2002 13:24:02 GMT."
             <Pine.LNX.4.33.0203111202410.25220-101000@sphinx.mythic-beasts.com> 
Date: Mon, 11 Mar 2002 07:35:34 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>The new aic7xxx driver (in 2.4.17, 2.5.1-pre1 and 2.5.6, at
>least) negotiates only 11.626MB/s transfers from my disks.
>The old one can extract 40MB/s transfers (though the disks
>themselves can only do a little over 20MB/s each).

Go into SCSI-Select and change all of the sync rate values to
something other than you want.  Save the changes.  Reboot.  Go
back into SCSI-Select and change the sync values to what you want.
The driver will then recognize them.

Some MB manufacturers using the aic7895 screwed up the initialation
of the serial eeprom while they were assembling their boards.  The
old driver tries to work around this, but the work-around means
converting one of the lower sync rates into meaning "full speed".
I decided that just wasn't safe to put in the new driver.

--
Justin
