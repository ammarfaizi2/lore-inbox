Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRKMXTg>; Tue, 13 Nov 2001 18:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279818AbRKMXT1>; Tue, 13 Nov 2001 18:19:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55565 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279814AbRKMXTS>; Tue, 13 Nov 2001 18:19:18 -0500
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Tue, 13 Nov 2001 23:26:27 +0000 (GMT)
Cc: r.turk@chello.nl (Rob Turk), linux-kernel@vger.kernel.org
In-Reply-To: <20011113120855.A25014@one-eyed-alien.net> from "Matthew Dharm" at Nov 13, 2001 12:08:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163mwl-0002jR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch doesn't prevent another application from getting more INQUIRY
> bytes.  What it does change is how much data the SCSI scanning loop looks
> for.  That data is requested, and then thrown away.  It's not kept around
> for anything.
> 
> If it were kept, I'd agree with you.  But it's not.  Some useful data is
> copied out of the INQUIRY result, and then the buffer is overwritten by the
> next probing request.

Ok I need to double check that. My merge of the 255 has a note saying for
fixing sane, but that doesnt mean someone didnt overfix the matter
