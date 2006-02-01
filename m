Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWBAP6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWBAP6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWBAP6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:58:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34495 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422651AbWBAP6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:58:42 -0500
Date: Wed, 1 Feb 2006 16:06:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: jgarzik@pobox.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, acahalan@gmail.com,
       "unlisted-recipients:; "@pop3.mail.demon.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43DE42DD.nail2AM41DPRR@burner>
Message-ID: <Pine.LNX.4.61.0602011601420.22529@yvahk01.tjqt.qr>
References: <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
 <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr> <43DDFBFF.nail16Z3N3C0M@burner>
 <20060130120408.GA8436@merlin.emma.line.org> <43DE3AE5.nail16ZL1UH7X@burner>
 <43DE4055.8090501@pobox.com> <43DE42DD.nail2AM41DPRR@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>>Cdrecord is a program that needs to be able to send any SCSI command as 
>> >>>it needs to be able to add new vendor unique commands for new drive/feature
>> >>>support.
>> >>
>> >>Right, but evidently it does not need the kernel to invent numbering.
>> >>dev=/dev/hdc works today.
>> > 
>> > Maybe, I will need to enforce to use official libscg device names in future....
>>
>> To burden users with yet another naming policy?
>
>Well, I am open to have an unbiased discussion that may have any result but 
>the parties should allow each other to convince by arguments.
>
The user should use what the OS uses. Cdrecord, or libscg, respectively, 
can invent any numbers it wants. IOW, "we" (read: I) would like to see
  cdrecord -dev=/dev/hdc on Linux

I am not sure if I understood your other mail on the cdrecord ML, but if 
the proper syntax would be
  cdrecord -dev=/dev/hdc:@
then
  /dev/hdc
could just be transparently turned into
  /dev/hdc:@
somewhere within the getopt part.

for other OS:
  cdrecord -dev=/dev/acd0 on FreeBSD
  cdrecord -dev=E: on Win32
    cdrecord -dev=\\cdrom0 if someone really wants for Win32
  cdrecord -dev=/dev/c0t0s0d0 on Solaris
(Don't shoot me. I unfortunately have to make a guess, since I have 
not done yet any cdrecord'ing[1] on OS other than Linux.)

[1] Well with Nero, but that's not cdrecord, as in "cdrecord'ing". :)


Jan Engelhardt
-- 
