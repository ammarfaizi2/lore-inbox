Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDUIYb>; Sun, 21 Apr 2002 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDUIYb>; Sun, 21 Apr 2002 04:24:31 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:33964 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S311262AbSDUIYa>; Sun, 21 Apr 2002 04:24:30 -0400
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200204210824.g3L8OR720085@ns.home.local>
Subject: Re: PATCH] Allow setuid/setgid core files
To: nawilson@nawilson.com
Date: Sun, 21 Apr 2002 10:24:26 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Neil,

I think I will try your patch since I have also had the same need
several times. In fact, not dumping a setuid core seems logical
for shared systems with lots of users, but on secured servers
which only host one daemon or two, and on which there's not any
user account, it's a bit annoying. In this case, if anyone gets
in the system, he's root anyway, so the initial protection
doesn't apply.

BTW, what uid/gid will the core get ? I think that it should get
the highest level so that if someone breaks in through a service
which uses this feature and which has dropped its uid/gid, at
least he cannot read eventual cores from previous attempts.
Comments ?

Willy

