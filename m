Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSLQGry>; Tue, 17 Dec 2002 01:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSLQGry>; Tue, 17 Dec 2002 01:47:54 -0500
Received: from ns.cinet.co.jp ([210.166.75.130]:54285 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264844AbSLQGrx>;
	Tue, 17 Dec 2002 01:47:53 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A31C@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Rusty Russell '" <rusty@rustcorp.com.au>
Cc: "'lkml '" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
Date: Tue, 17 Dec 2002 15:55:39 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Rusty Russell
To: Zwane Mwaikambo
Cc: vamsi@in.ibm.com; lkml
Sent: 2002/12/17 9:17
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 

> Yes, the filenames are unchanged.  But if you modprobe snd-mixer-oss,
> you'll see snd_mixer_oss in /proc/modules.  But rmmod "snd-mixer-oss"
> works as expected.  Basically, the kernel and tools see them as
> equivalent: anything else is a bug, please report.

I have another problem related this one.
"options snd-cs4232 port=0xf44 ..." in modprobe.conf is ignored.
This is created by modprobe.conf2modprobe.conf in module-init-
tools 0.9.3.
When I rewite it to "options snd_cs4232 port=0xf44 ..." by hand,
it works fine.

Regards,
Osamu
