Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265085AbSLMQRO>; Fri, 13 Dec 2002 11:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSLMQRN>; Fri, 13 Dec 2002 11:17:13 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:4992 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S265085AbSLMQRM>;
	Fri, 13 Dec 2002 11:17:12 -0500
Message-ID: <3DFA09A4.7080701@walrond.org>
Date: Fri, 13 Dec 2002 16:24:04 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, I think marc was right...

daedalus@bob sym $ ls -l
total 4
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:19 a -> b
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:19 b -> c
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:20 c -> d
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:20 d -> e
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:20 e -> f
lrwxrwxrwx    1 daedalus users           1 Dec 13 16:20 f -> g
lrwxrwxrwx    1 daedalus users           4 Dec 13 16:21 g -> test
-rw-r--r--    1 daedalus users           6 Dec 13 16:18 test
daedalus@bob sym $ cat a
cat: a: Too many levels of symbolic links
daedalus@bob sym $ cat b
cat: b: Too many levels of symbolic links
daedalus@bob sym $ cat c
Hello


