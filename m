Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290291AbSAOWSy>; Tue, 15 Jan 2002 17:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289712AbSAOWRc>; Tue, 15 Jan 2002 17:17:32 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:20906 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289704AbSAOWRR>;
	Tue, 15 Jan 2002 17:17:17 -0500
Date: Tue, 15 Jan 2002 22:17:13 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, esr@thyrsus.com
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
Message-ID: <195317834.1011133033@[195.224.237.69]>
In-Reply-To: <E16QESB-0002xq-00@the-village.bc.nu>
In-Reply-To: <E16QESB-0002xq-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 14 January, 2002 9:15 PM +0000 Alan Cox 
<alan@lxorguk.ukuu.org.uk> wrote:

>> "Crap." Melvin thinks.  "I don't remember what kind of network card I
>> compiled in.  Am I going to have to open this puppy up just to eyeball
>> the hardware?" Doing that would take time Melvin was planning to spend
>
> So he builds a kernel with modular setups just like the vendor kernel.

& if this is the sole aim, just (configurably no doubt) stick
.config somewhere in initramfs as part of the build process
and you have no parsing to do whatsoever.

For added contraversiality, optionally stick it (gzipped at source)
inside some module that registers an entry into /proc. This
means it only occupies its gzipped space in RAM. & yes I know
this has been discussed before.

However, I'd submit that recovering the previous .config file
is the least of your problems. If I'm the only one who tries
to beg/borrow/steal config fies form other machines I've built,
the net at large, etc. etc., then tweak then, rather than
mis-answer a seemingly endless sequence of questions, I'll eat
hat.

Besides if the user is clued up enough to go buy (for example)
a GigE card, they will know it's possible they have to turn
the option on in the driver, and making small incremental
changes like that are relatively easy. What's hard is (for
instance) when kernel builds with particular .config files
hang hard on boot. Normally once you have something 'nearly
working' tweaking it to suit your taste is relatively
easy (as you change only one thing at a time). But my
practice, and I'm sure I'm not alone, is to start off
either with a config I've used elsewhere, or one someone
else has developed for that machine (the latter being
the only option for Aunt Tillie). [I then do a diff between
what I used, and the other option, and start integrating
changes - being able to show Aunt Tillie the difference
between vendor options and ones 'for her machine' would
doubtless be useful]

--
Alex Bligh
