Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131942AbRC1ANy>; Tue, 27 Mar 2001 19:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131986AbRC1ANs>; Tue, 27 Mar 2001 19:13:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48140 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S131942AbRC1AM2>; Tue, 27 Mar 2001 19:12:28 -0500
Message-ID: <3AC12C12.D86312D7@transmeta.com>
Date: Tue, 27 Mar 2001 16:10:58 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <Pine.LNX.4.31.0103271606420.25282-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 27 Mar 2001, Alan Cox wrote:
> >
> > A major for 'disk' generically makes total sense. Classing raid controllers
> > as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> > solve a lot of misery
> 
> Exactly. It's just that for historical reasons, I think the major for
> "disk" should be either the old IDE or SCSI one, which just can show more
> devices. That way old installers etc work without having to suddenly start
> knowing about /dev/disk0.
> 
> But hey, maybe I'm wrong.
> 

They would still have to change, since now we'd have to worry about
/dev/hd* having changed meanings; also, you now cannot create a
backward-compatible /dev since /dev/hdc is (22,0), etc, in the current
scheme.  The SCSI scheme is also not acceptable; it has been a
long-standing problem that it doesn't allow enough partitions per disk.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
