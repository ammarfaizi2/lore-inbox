Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSHaRrH>; Sat, 31 Aug 2002 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHaRrH>; Sat, 31 Aug 2002 13:47:07 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:18436 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S317836AbSHaRrH>;
	Sat, 31 Aug 2002 13:47:07 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208311751.g7VHpUA02632@oboe.it.uc3m.es>
Subject: using a device in O_DIRECT mode through a FS
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Sat, 31 Aug 2002 19:51:30 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've managed to mount a block device in "direct" mode in 2.5.31,
by modifying the block driver to set the O_DIRECT flag on opens, but
this doesn't affect subsequent accesses to files on the mounted
filesystem.  They're cached in VMS as usual, instead of going straight
to the metal and back.

Can anyone indicate to me what I have to do in order to make all
accesses to structures on the mounted FS avoid VMS also?  Is it a FS
thing?  If so, what do I have to alter where in the FS driver? (Yes,
I imagine it's whatever the open call translates to ..).

Peter
