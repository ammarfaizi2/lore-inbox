Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136107AbRD0QxK>; Fri, 27 Apr 2001 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136109AbRD0QxA>; Fri, 27 Apr 2001 12:53:00 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136107AbRD0Qws>; Fri, 27 Apr 2001 12:52:48 -0400
Date: Fri, 27 Apr 2001 09:52:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010427095840.A701@suse.cz>
Message-ID: <Pine.LNX.4.21.0104270951270.2067-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, Vojtech Pavlik wrote:
> 
> Actually this is done quite often, even on mounted fs's:
> 
> hdparm -t /dev/hda

Note that this one happens to be ok.

The buffer cache is "virtual" in the sense that /dev/hda is a completely
separate name-space from /dev/hda1, even if there is some physical
overlap.

		Linus

