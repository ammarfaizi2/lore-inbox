Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSLNApB>; Fri, 13 Dec 2002 19:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265516AbSLNApB>; Fri, 13 Dec 2002 19:45:01 -0500
Received: from [209.184.141.189] ([209.184.141.189]:6386 "HELO ubergeek")
	by vger.kernel.org with SMTP id <S265477AbSLNApA>;
	Fri, 13 Dec 2002 19:45:00 -0500
Subject: Help Understanding what causes kernel stack overflow.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1039827096.31946.23.camel@UberGeek>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 18:51:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.19-aa1
FS are all XFS. Kernel has no modules, except Qlogic drivers(6.01-fo)

I've been dealing with some pretty regular, albeit severe stack overflow
issues which crashes one of my two DB servers from time to time. We
currently are on a schedule to reboot them every week to prevent the
systems from hanging/crashing/etc. 

We recently were able to make some correlation to backup times and the
potential stack overflow detection messages. I've got a traces from our
kernel log and messages files. I was curious if there were currently any
tools to examine the stack call traces in detail. 

I tried using ksymoops, but it really didn't give me any more than I
already had in messages. Any advice on the *best* way to proceed
debugging what is causing stack overflows given I have the call traces?

Currently, I've dumped all the objects from the running kernel(objdump
-Dr vmlinux) and will search for the "sub" lines which correspond to
%esp. I'll then take the functions which are listed in my call trace,
and add up the total each function uses to see if that is the right
path, then to try an reproduce it, given the call traces I have. 


Any help on doing this would be wonderful. 


-- 
GrandMasterLee <masterlee@digitalroadkill.net>
