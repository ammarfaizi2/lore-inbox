Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSH0IyK>; Tue, 27 Aug 2002 04:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSH0IyK>; Tue, 27 Aug 2002 04:54:10 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:5905 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S315416AbSH0IyJ>;
	Tue, 27 Aug 2002 04:54:09 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208270858.g7R8wJF15076@oboe.it.uc3m.es>
Subject: block device/VM question
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Tue, 27 Aug 2002 10:58:19 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there any way of turning off VMS caching for a block device?

I want all reads to come down to the driver, where I decide what to do
about them.  I don't want reads to read locally cached buffers in VMS
unless I say so.  The reason is that the device might have a remote
writer.

I'll have a look at the raw character device later (but I recall
having looked before without it telling me anything - probably
they make a fake request and transfer it to the device queue
directly and treat the return with their own substituted end_req).
I need a block device - I can't mount a character device. Now
there's an idea! A mouse represented as a file system ..

Peter
