Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbTBWOXS>; Sun, 23 Feb 2003 09:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTBWOXS>; Sun, 23 Feb 2003 09:23:18 -0500
Received: from daimi.au.dk ([130.225.16.1]:14822 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S268472AbTBWOXQ>;
	Sun, 23 Feb 2003 09:23:16 -0500
Message-ID: <3E58DBB1.7849015E@daimi.au.dk>
Date: Sun, 23 Feb 2003 15:33:21 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nataraja kumar <hainattu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: A question on kernel stack
References: <20030221180508.18214.qmail@web20206.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nataraja kumar wrote:
> 
> hi,
> my apologies if i am wrong. please let me know
> why does kernel use kernel stack when process jumps
> from user mode to kernel mode. why can't user stack
> be used ?

1) The user stack is in user space, which can only be
   accessed by this process (or any sharing the same
   vm). Trying to access the stack of another process
   would fail.
2) The stack pointer is used to find the task_struct
   of the current process. You'd need another location
   for the task_struct, and a way to find it.
3) Various security issues as others have already
   mentioned.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
