Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318131AbSIORKp>; Sun, 15 Sep 2002 13:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIORKo>; Sun, 15 Sep 2002 13:10:44 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:18066 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S318131AbSIORKn>;
	Sun, 15 Sep 2002 13:10:43 -0400
Date: Sun, 15 Sep 2002 19:15:38 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [BUG?] binfmt_script: interpreted interpreter doesn't work
Message-ID: <Pine.GSO.4.30.0209151910220.22107-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

This may well not be bug, rather an intended feature, but please enlighten
me why the following doesn't work:

I have two scripts:
/home/pozsy/a:
#!/bin/sh
echo "Hello from a!"

/home/pozsy/b:
#!/home/pozsy/a
echo "hello from b!"


Both of them has +x permissions.
But I cannot execute the /home/pozsy/b script:

[pozsy:~]$ strace -f /home/pozsy/b
execve("/home/pozsy/b", ["/home/pozsy/b"], [/* 25 vars */]) = 0
strace: exec: Exec format error
[pozsy:~]$


Isn't this "indirection" allowed?

-- 
pozsy

