Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130356AbRBMXdE>; Tue, 13 Feb 2001 18:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130212AbRBMXcy>; Tue, 13 Feb 2001 18:32:54 -0500
Received: from CRUSH.REM.CMU.EDU ([128.2.81.185]:2176 "EHLO crush.hunch.net")
	by vger.kernel.org with ESMTP id <S129930AbRBMXcg>;
	Tue, 13 Feb 2001 18:32:36 -0500
Date: Tue, 13 Feb 2001 18:35:59 -0500 (EST)
From: John Langford <l_k_account@crush.hunch.net>
To: Colonel <klink@clouddancer.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 loopback FS partial fix
In-Reply-To: <20010213212231.B1CC4669F1@mail.clouddancer.com>
Message-ID: <Pine.LNX.4.21.0102131831420.1041-100000@crush.hunch.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent - this solved my problems.  I stress tested the loopback device
with a big copy and it seemed to work.  I also made losetup use open64:

[root@crush mount]# diff lomount.c lomount.c~
230c230
<       if ((ffd = open64 (file, mode)) < 0) {
---
>       if ((ffd = open (file, mode)) < 0) {

and gave it a 10GB file.  This seems to be working fine as well.

-John

