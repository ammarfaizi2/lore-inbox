Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSGCKAM>; Wed, 3 Jul 2002 06:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSGCKAL>; Wed, 3 Jul 2002 06:00:11 -0400
Received: from [62.70.58.70] ([62.70.58.70]:29320 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S316088AbSGCKAK> convert rfc822-to-8bit;
	Wed, 3 Jul 2002 06:00:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: lilo/raid?
Date: Wed, 3 Jul 2002 12:02:46 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207011758180.3104-100000@netfinity.realnet.co.sz> <200207021333.36435.roy@karlsbakk.net> <3D22C735.7A5F299A@aitel.hist.no>
In-Reply-To: <3D22C735.7A5F299A@aitel.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207031202.46441.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What is the reason of using swap for cache buffers?????
>
> To be precise - swap is never used _for_ cache buffers - you'll
> never see file contents in the swap partition, perhaps with
> the exception of tmpfs stuff.
>
> But aggressive caching may indeed push other stuff into swap,
> typically little-used program memory.

ok.
tell me, then

When having an http-server-of-choice (tried several), I start downloading 
10-50 files at 4Mbps. After some time, the server OOMs. The only processes 
running are syslog, nfs daemons (idle) and the web server. This happens 
without swap or with swap (1gig swap - fills up, and the server dies).

My last thread about it was "[BUG] 2.4 VM sucks. Again". After a rather 
experimental patch my akpm, the problem was solved.

<snip>

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

