Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSICPqL>; Tue, 3 Sep 2002 11:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSICPqL>; Tue, 3 Sep 2002 11:46:11 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:16901 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318795AbSICPqK>;
	Tue, 3 Sep 2002 11:46:10 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209031550.g83FogE03775@oboe.it.uc3m.es>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <Pine.LNX.4.44L.0209031243450.1519-100000@duckman.distro.conectiva>
 from Rik van Riel at "Sep 3, 2002 12:44:42 pm"
To: Rik van Riel <riel@conectiva.com.br>
Date: Tue, 3 Sep 2002 17:50:42 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Rik van Riel wrote:"
> On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> 
> > I assumed that I would need to make several VFS operations atomic
> > or revertable, or simply forbid things like new file allocations or
> > extensions (i.e.  the above), depending on what is possible or not.
> 
> > No, I don't want ANY FS. Thanks, I know about these, but they're not
> > it. I want support for /any/ FS at all at the VFS level.
> 
> You can't.  Even if each operation is fully atomic on one node,
> you still don't have synchronisation between the different nodes
> sharing one disk.

Yes, I do have synchronization - locks are/can be shared between both
kernels using a device driver mechanism that I implemented. That is
to say, I can guarantee that atomic operations by each kernel do not
overlap "on the device", and remain locally ordered at least (and
hopefully globally, if I get the time thing right).

It's not that hard - the locks are held on the remote disk by a
"guardian" driver, to which the drivers on both of the kernels
communicate.  A fake "scsi adapter", if you prefer.

> You really need filesystem support.

I don't think so. I think you're not convinced either! But
I would really like it if you could put your finger on an
overriding objection.

Peter
