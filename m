Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262531AbREUXOw>; Mon, 21 May 2001 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbREUXOm>; Mon, 21 May 2001 19:14:42 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:44538 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262531AbREUXOa>; Mon, 21 May 2001 19:14:30 -0400
Message-Id: <l03130306b72f4c1f49be@[192.168.239.105]>
In-Reply-To: <E151oq6-0003iB-00@the-village.bc.nu>
In-Reply-To: <18583.990447323@redhat.com> from "David Woodhouse" at May 21,
 2001 01:15:23 PM
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 22 May 2001 00:11:21 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dwmw2@infradead.org (David Woodhouse)
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Background to the argument about CML2 design philosophy
Cc: helgehaf@idb.hist.no (Helge Hafting), esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 2) Have a HACKERS submenu system which contains all the derivations
>> > that could *possibly* be un-defaulted, and allow our intrepid hacker
>> > to explicitly force each to a value or leave unset.
>>
>> I prefer the former, which is how it's already implemented in CML1.
>
>Its called Debugging in CML1 in -ac for a reason btw. Because its called
>debugging I get plenty of reports that start

I think "Debugging" and "HACKERS" go in separate categories.  "Debugging"
is for pinpointing problems in the *same* configuration, "HACKERS" is for
making *different* configurations.

Not that I really care what it's called, provided the concept gets thought
about.  If I select MAC68K and SCSI, it's perfectly reasonable for the two
"standard" SCSI drivers to be compiled-in for most people.  But if I run
into a PowerBook 190 or Quadra 840av (which, if I'm not much mistaken,
don't use the standard chipsets - and I happen to have access to both of
them), I might want to turn them off and turn on my own hacked-up driver.
Or I might want to turn off the one I'm not using, to save space on that
old spare 4Mb Classic II.

And in fact this is a non-issue at present - the SCSI rulesfile has "unless
MAC suppress MAC_SCSI SCSI_MAC_ESP" and NOTHING which forces MAC_SCSI and
SCS_MAC_ESP to "on" if I'm running a Mac.  As far as I can tell, both would
default to "off", and are merely hidden if I happen not to be running such
a machine.

For the moment, I'll be happy if the rulesfile remains similar in function
to CML1 but with the added intelligence CML2 brings with it by default.  If
in the future someone wants to add "Aunt Tillie" features, then sensible
defaults can easily be added and over-ridden.  I think I'd like CML2 to
remember which options are explicitly set and which ones I left alone (if
it doesn't do so already) - that will go a long way towards helping Aunt
Tillie in the long run.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


