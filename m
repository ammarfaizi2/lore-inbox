Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSE2J35>; Wed, 29 May 2002 05:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSE2J34>; Wed, 29 May 2002 05:29:56 -0400
Received: from vulcan.alphanet.ch ([62.2.159.14]:25620 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S314634AbSE2J34>; Wed, 29 May 2002 05:29:56 -0400
Date: Wed, 29 May 2002 11:25:35 +0200 (MEST)
From: Marc SCHAEFER <schaefer@alphanet.ch>
Reply-To: Marc SCHAEFER <schaefer@alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE hotswap
In-Reply-To: <Pine.LNX.3.96.1020528180129.20664B-100000@defian.alphanet.ch>
Message-ID: <Pine.LNX.3.96.1020529111715.1628A-100000@defian.alphanet.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2002, Marc SCHAEFER wrote:

> I would like to implement real hotswapping support with IDE drives in the
> following setup:

Ok, after a few more searches, and very nice help from a linux-kernel
reader, I found notably a past thread which is full of very interesting
information:

   http://search.alphanet.ch/cgi-bin/search.cgi?subject=IDE+and+hot-swap+disk+caddies&max_results=10&type=long&domain=ml-linux-kernel

(put 31 instead of 10 if you want the whole thing in one page).

We learn there that:

   - someone else tried the module stuff, but failed (I had success)

        I have noticed, by creating a simple boot floppy with IDE modules
        (ide_mod, ide_disk, ide_probe_mod), that if you remove ide_probe_mod, 
        replace the disk, and reinsert ide_probe_mod, the disk is detected
        correctly (geometry, size, etc) after reinsert or even type
        change.

   - some chipset support tri-stating the bus (hdparm -b 2), I need
     to investigate if this is implemented/works on my hardware. It seems
     to work very well especially if you only put one device per bus,
     which is my goal.

   - some disks can be marked `hotswap' (-x option of hdparam), no idea
     what it means yet.

So I am going to investigate in this direction, maybe combining the
tristate with partial re-detection.

(I also got mail asking me to sign before an NDA before telling me
anything, that was a bit stupid. AFAIK saying `doing it without tristating
can fry your hardware' is not patented yet. Maybe it's this world which is
going insane because of patents).

Thank you for your time.

