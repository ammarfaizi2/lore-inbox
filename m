Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262629AbSJGUCe>; Mon, 7 Oct 2002 16:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbSJGUB4>; Mon, 7 Oct 2002 16:01:56 -0400
Received: from 62-190-203-30.pdu.pipex.net ([62.190.203.30]:11012 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262629AbSJGUBc>; Mon, 7 Oct 2002 16:01:32 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210072015.g97KFjch003948@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 7 Oct 2002 21:15:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007162318.A758@ucw.cz> from "Vojtech Pavlik" at Oct 07, 2002 04:23:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally re-assembled the laptop :-)

> > I didn't, but I've compiled a new kernel with it in.  Unfortunately,
> > it doesn't seem to do anything useful :-(.
> > 
> > cat /dev/input/eventX | hexdump
> > 
> > returns nothing, not even for keyboard events, which makes me think
> > I've gone wrong somewhere :-/
> 
> Have you tried all of them (0, 1, 2 ...)? Btw, you can compile evbug in
> also.

Whoops, me being silly again, I actually created a single device node
called /dev/input/eventX instead of event1, event2, etc.  :-)

> > mouse
> > 
> >  Left button - 09 00 00 08 00 00
> > Right button - 0a 00 00 08 00 00
> > 
> > trackball
> > 
> >  Left button - 01 00 00 00 00 00
> > Right button - 02 00 00 00 00 00
> 
> Hmm, interesting ... let's see what that means ...
> 
> Indeed the 0x08 byte indicates the beginning of a packet. The driver
> synchronizes on that, and when it's missing, it ignores the packets.
> Thus, it ignores all the packets from the trackball.
> 
> This patch should fix that:

It does.  Cool!

GPM and X work perfectly.

Cheers!

John.
