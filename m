Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277123AbRJLAgN>; Thu, 11 Oct 2001 20:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277129AbRJLAgC>; Thu, 11 Oct 2001 20:36:02 -0400
Received: from web20902.mail.yahoo.com ([216.136.226.224]:5517 "HELO
	web20902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277123AbRJLAfq>; Thu, 11 Oct 2001 20:35:46 -0400
Message-ID: <20011012003617.25581.qmail@web20902.mail.yahoo.com>
Date: Thu, 11 Oct 2001 17:36:17 -0700 (PDT)
From: Amit Purohit <whoami_t@yahoo.com>
Subject: Right place to store process specific data
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to have a fast common shared memory between
kernel and user. I am using a system call which uses
"map_user_kiobuf" on user allocated memory to satisfy
this need. 

The system call returns the physical address to the
user so that the user can pass this address to the
kernel, next time, when the kernel wants to access the
shared memory. 

I want to check whether the address passed by the user
is valid or not. For that I want to store the address
somewhere into the process structure when I generate
it through "map_user_kiobuf".( may be task_struct ).
But I am not able to find a place to keep the address.
( Any reserved variables ).

My first question is
1>Is there any place in the current process context   

  where I can store the address?

2>Is there any other method to have fast shared memory

  between user and kernel.

--Amit

__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
