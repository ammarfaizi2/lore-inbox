Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbRFYT25>; Mon, 25 Jun 2001 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFYT2r>; Mon, 25 Jun 2001 15:28:47 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:16760 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S263433AbRFYT2g>; Mon, 25 Jun 2001 15:28:36 -0400
Message-ID: <3B379058.FF66AF14@sgi.com>
Date: Mon, 25 Jun 2001 12:26:16 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: user limits for 'security'?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen some people saying that user-limits are an essential part of a
secure system to prevent local DoS attacks.  Given that, should
a system call like 'fork' return -EPERM if the user has reached their
limit?

My local manpage (SuSE 7.2 system) says this under fork:

ERRORS
       EAGAIN fork  cannot allocate sufficient memory to copy the
              parent's page tables and allocate a task  structure
              for the child.
-----
    Should the man page be updated to reflect that EAGAIN is returned
when the user has reached their limit?  From a user-monitoring point
of view, it might be security relevant to know if a EAGAIN is being
returned because the system really is low on resources or if it
is a user hitting their limit.

--
The above thoughts and            | I know I don't know the opinions
writings are my own.              | of every part of my company. :-)
L A Walsh, law at sgi.com         | Sr Eng, Trust Technology
01-650-933-5338                   | Core Linux, SGI



