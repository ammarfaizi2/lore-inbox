Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbRE0Nrp>; Sun, 27 May 2001 09:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbRE0Nrf>; Sun, 27 May 2001 09:47:35 -0400
Received: from pop.gmx.net ([194.221.183.20]:46796 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262036AbRE0NrU>;
	Sun, 27 May 2001 09:47:20 -0400
Message-ID: <3B1101ED.3BF181F6@gmx.de>
Date: Sun, 27 May 2001 15:32:29 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105251300000V.06233@starship> <3B0F1DF9.238C01B9@gmx.de> <0105270036060Z.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> It won't, the open for "." is handled in the VFS, not the filesystem -
> it will open the directory.  (Without needing to be told it's a
> directory via O_DIRECTORY.)  If you do open("magicdev") you'll get the
> device, because that's handled by magicdevfs.

You really mean that "magicdev" is a directory and:

	open("magicdev/.", O_RDONLY);
	open("magicdev", O_RDONLY);

would both succeed but open different objects?

> I'm not claiming there isn't breakage somewhere,

you break UNIX fundamentals.  But I'm quite relieved now because I'm
pretty sure that something like that will never go into the kernel.

Ciao, ET.
