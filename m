Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbREVPiE>; Tue, 22 May 2001 11:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261898AbREVPh5>; Tue, 22 May 2001 11:37:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8465 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261882AbREVPhj>; Tue, 22 May 2001 11:37:39 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: matthew@wil.cx (Matthew Wilcox)
Date: Tue, 22 May 2001 16:31:37 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), matthew@wil.cx (Matthew Wilcox),
        torvalds@transmeta.com (Linus Torvalds),
        ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        viro@math.psu.edu (Alexander Viro), pavel@suse.cz (Pavel Machek),
        rgooch@ras.ucalgary.ca (Richard Gooch),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20010522163135.N23718@parcelfarce.linux.theplanet.co.uk> from "Matthew Wilcox" at May 22, 2001 04:31:35 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152E8H-00024B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> `the class of devices in question' was cryptographic devices, and possibly
> other transactional DSPs.  I don't consider audio to be transactional.
> in any case, you can do transactional things with two threads, as long
> as they each have their own fd on the device.  Think of the fd as your
> transaction handle.

Thats a bit pathetic. So I have to fill my app with expensive pthread locks
or hack all the drivers and totally change the multi-open sematics in the ABI

I think I'll stick to ioctl cleaned up

