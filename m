Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSIYAnR>; Tue, 24 Sep 2002 20:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSIYAnR>; Tue, 24 Sep 2002 20:43:17 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:190
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261867AbSIYAnP>; Tue, 24 Sep 2002 20:43:15 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200209250047.g8P0lpr22153@www.hockin.org>
Subject: Re: alternate event logging proposal
To: greearb@candelatech.com (Ben Greear)
Date: Tue, 24 Sep 2002 17:47:51 -0700 (PDT)
Cc: thockin@sun.com (Tim Hockin), jgarzik@pobox.com (Jeff Garzik),
       bhards@bigpond.net.au (Brad Hards),
       cfriesen@nortelnetworks.com (Chris Friesen),
       rusty@rustcorp.com.au (Rusty Russell),
       linux-kernel@vger.kernel.org (linux-kernel mailing list),
       alan@lxorguk.ukuu.org.uk (Alan Cox),
       cgl_discussion@osdl.org (cgl_discussion mailing list),
       evlog-developers@lists.sourceforge.net (evlog mailing list),
       ipslinux@us.ibm.com ("ipslinux (Keith Mitchell)"),
       torvalds@home.transmeta.com (Linus Torvalds),
       hien@us.ibm.com (Hien Nguyen), kenistoj@us.ibm.com (James Keniston),
       sullivam@us.ibm.com (Mike Sullivan)
In-Reply-To: <3D90FED3.5060705@candelatech.com> from "Ben Greear" at Sep 24, 2002 05:09:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > a single device_event file that a daemon reads and dispatches events (I 
> > like this one because the daemon is already written, just poorly named - 
> > acpid)
> 
> Couldn't you just have the message sent to every process that has
> opened the file (and have every interested process open the file and
> read it in a non-blocking or blocking mode?)

Sure, but then every process that is concerned with a single event has to
not only receive every event, but parse every event.  And if this is to be
truly generic, that could be a lot of events.

> That seems to negate the need for something like acpid, but it does
> not preclude it's use.

True, and if a dev_event file were created, I'd consider doing it that way.
But in that case it's easier for apps to talk to eventd (nee acpid) and get
only the messages they want.

Tim
