Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSDVTRJ>; Mon, 22 Apr 2002 15:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSDVTRI>; Mon, 22 Apr 2002 15:17:08 -0400
Received: from mail.storm.ca ([209.87.239.66]:50335 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S314457AbSDVTRI>;
	Mon, 22 Apr 2002 15:17:08 -0400
Message-ID: <3CC4541B.1999F853@storm.ca>
Date: Mon, 22 Apr 2002 14:19:07 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-26mdkenterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Libor Vanlk <libor@conet.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
In-Reply-To: <3CC3ECD2.9000205@conet.cz> <20020422170745.GD3017@turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Apr 22, 2002  12:58 +0200, Libor Vanlk wrote:
> > I'm going to start my dissertation work which is "Adding snapshop
> > capability to Linux kernel with copy-on-write support". ...

> > So I'd like if you can send me any suggestions/tips/warnings/links etc.
> > before I start coding so I know what should I avoid/use.
> 
> Please see:
> http://www-mddsp.enel.ucalgary.ca/People/adilger/snapfs/
> 
> What you describe is exactly what snapfs does. ...

A related thing to look at would be the Plan 9 file system.
http://www.cs.bell-labs.com/plan9dist/

It is an entirely different design using copy-on-write and a
form of snapshotting such that something like:

cd //2001/12/25/foo

puts the user in directory /foo as it was at daily backup time
on Christmas day last year.

The original Plan 9 system used WORM drives with hard drives
acting as cache. I suspect the design could work without WORM.
