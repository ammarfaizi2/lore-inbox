Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132595AbRC1VnE>; Wed, 28 Mar 2001 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132591AbRC1Vmv>; Wed, 28 Mar 2001 16:42:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3601 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S132599AbRC1VmO>; Wed, 28 Mar 2001 16:42:14 -0500
Message-ID: <3AC25A57.F00F1EE1@transmeta.com>
Date: Wed, 28 Mar 2001 13:40:39 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <Pine.LNX.4.31.0103271545500.25282-100000@penguin.transmeta.com> <3AC25657.6CC01DFB@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Then please please please demangle other cases as well!
> IDE is the one which is badging my head most. SCSI as well...
> 
> Granted I wouldn't mind a rebot with new /dev/* once!
> 

This seems to me to really be the kind of thing devfs does better than
trying to play number games.  devfs (and I'm talking in the abstract, not
necessarily the existing implementation) can present things in multiple
views, using hard links.  This is a Good Thing, because it lets you ask
different questions and get appropriate answers (one question is "what
are my disks", another is "what are my SCSI devices".)

As far as IDE is concerned, I repeat my call for "generic ATAPI" to go
along with "generic SCSI"...

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
