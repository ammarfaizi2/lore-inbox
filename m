Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264563AbSIQT71>; Tue, 17 Sep 2002 15:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264565AbSIQT71>; Tue, 17 Sep 2002 15:59:27 -0400
Received: from 62-190-218-75.pdu.pipex.net ([62.190.218.75]:10251 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S264563AbSIQT7Y>; Tue, 17 Sep 2002 15:59:24 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209172012.g8HKCFrG004537@darkstar.example.net>
Subject: Re: Problems accessing USB Mass Storage
To: gen-lists@blueyonder.co.uk (Mark C)
Date: Tue, 17 Sep 2002 21:12:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032291993.1276.12.camel@stimpy.angelnet.internal> from "Mark C" at Sep 17, 2002 08:46:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a bit like what we (JE, David Brownell, and I) saw at
> > the USB plugfest in 1999.  We had a camera device that we
> > couldn't mount as a filesystem, but we could dd it.
> > When we did that and studied the dd-ed file, we could see a
> > FAT filesystem beginning after the first <N> blocks (but more than
> > 25 sectors IIRC -- more like after 50-100 KB, or maybe even more).
> 
> Sorry to sound a bit bewildered, but would be the next best thing for me
> to do on this?, 
> I have also been advised by Jonathan Corbet 
> to use dd to copy your card to disk with an offset of 25

Have you tried reading from a different card?  The common opinion seems to be that the actual data starts some way in to the card, and as you get an input/output error when you try to access the card from the begining, it could be that there is a genuine media error, that is not showing up when you use drivers from another OS, that do not attempt to read those first few blocks, because they 'know' where the filesystem begins.

Just an idea, anyway.

John.
