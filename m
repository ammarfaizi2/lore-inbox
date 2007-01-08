Return-Path: <linux-kernel-owner+w=401wt.eu-S1030444AbXAHB7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbXAHB7z (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 20:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbXAHB7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 20:59:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3052 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030444AbXAHB7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 20:59:54 -0500
Date: Mon, 8 Jan 2007 02:59:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Willy Tarreau <w@1wt.eu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings
Message-ID: <20070108015958.GT20714@stusta.de>
References: <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org> <20070107170656.GC21133@flint.arm.linux.org.uk> <Pine.LNX.4.61.0701072009430.4365@yvahk01.tjqt.qr> <20070107204834.GU24090@1wt.eu> <20070107233750.GL20714@stusta.de> <20070108003857.GE435@1wt.eu> <45A19F3A.5030800@imap.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A19F3A.5030800@imap.cc>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 02:32:42AM +0100, Tilman Schmidt wrote:
> Am 08.01.2007 01:38 schrieb Willy Tarreau:
>...
> > And I'm not even
> > discussing the stupidity which requires that you read a whole text to get
> > its number of characters !
> 
> Personally I find the requirement to know the number of characters in a text
> rather unusual, so I wouldn't base a decision for an encoding on that. In
> fact, I cannot remember ever really wanting to know the actual number of
> characters in a text. The number of bytes occupied on storage, ok. The
> number of letters, of words, of lines, perhaps even the number of printable
> characters, all potentially interesting, depending on the application.
> But the raw number of characters? I don't know what that might serve for.

Also note that the UTF-32 Unicode encoding would offer this property, 
but with the following disadvantages compared to the UTF-8 Unicode 
encoding:
- 7bit ASCII is not a subset of UTF-32 losing a lot of compatibility
  (code 7bit ASCII with some UTF-8 in the comments is no problem
   for not-Unicode aware systems except for slight misdisplayments 
   of the comments)
- UTF-32 has up to 4 times the size of UTF-8

There's also the point that you can use e.g. "wc" or your editor for 
counting the characters.

> HTH
> Tilman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

