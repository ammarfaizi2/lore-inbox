Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281844AbRKRCft>; Sat, 17 Nov 2001 21:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRKRCfj>; Sat, 17 Nov 2001 21:35:39 -0500
Received: from cygnus.veloxia.com ([213.0.31.24]:47326 "HELO
	cygnus.veloxia.com") by vger.kernel.org with SMTP
	id <S281844AbRKRCfX> convert rfc822-to-8bit; Sat, 17 Nov 2001 21:35:23 -0500
Message-Id: <5.1.0.14.2.20011118033452.037a5728@pop.veloxia.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 18 Nov 2001 03:41:38 +0100
To: Davide Libenzi <davidel@xmailserver.org>
From: David Sanchez <dsanchez@veloxia.com>
Subject: Re: Possible bug; latest kernels with LinuxThreads
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111171834100.1011-100000@blue1.dev.mcafeela
 bs.com>
In-Reply-To: <5.1.0.14.2.20011118025147.035feb08@pop.veloxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>The line marked >>>> is line 488 in pthread.c , are you plain sure that
>you're not passing a NULL thread id ptr ?

Totally sure :-)

#0 0x40053f0f in __pthread_create_2_1 (thread=0x40244fc4, attr=0x40244fc8,

thread = 0x40244fc4 and attr=0x40244fc8, both parameters are inside a class 
of type MCThread, which begins with:

class MCThread {

protected:
         pthread_t m_thread;
         pthread_attr_t m_thread_attr;

Class is correctly allocated with "new", and also remember that the daemon 
runs without any problem and in a production environment with kernel 2.4.9 
and lowers.

Thank you very much,

David Sánchez
Veloxia Network,S.L.

dsanchez@veloxia.com

