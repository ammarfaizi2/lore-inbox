Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbUAEEQR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265884AbUAEEQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:16:17 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:24527 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265881AbUAEEQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:16:14 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16376.58584.518664.138740@wombat.chubb.wattle.id.au>
Date: Mon, 5 Jan 2004 15:15:20 +1100
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040104230104.A11439@pclin040.win.tue.nl>
References: <20040103040013.A3100@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
	<20040103141029.B3393@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
	<20040104000840.A3625@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
	<20040104034934.A3669@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	<20040104142111.A11279@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	<20040104230104.A11439@pclin040.win.tue.nl>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:

Andries> On Sun, Jan 04, 2004 at 01:05:20PM -0800, Linus Torvalds
Andries> wrote:

Andries> Surprise! Are you leaving POSIX? Or ditching NFS?  Or
Andries> demanding that NFS servers must never reboot?

Andries> A common Unix idiom is testing for the identity of two files
Andries> by comparing st_ino and st_dev.  A broken idiom?

It's worse than that.  You can do
     mknod fred b maj minor
anywhere on any UNIX filesystem and expect it to a) work and b) refer
to the same device for all time until it is removed. However, this
doesn't appear to be guaranteed by SUS -- the only guarantees are that
the dev_t returned from the stat() family of calls is unique within a LAN.

I know that Linux already breaks this (the stupid /dev/sg[0-9] that
depend not on the SCSI bus and lun but on the order they're detected,
for example) 
