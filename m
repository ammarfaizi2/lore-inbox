Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280689AbRKBNhM>; Fri, 2 Nov 2001 08:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280690AbRKBNhE>; Fri, 2 Nov 2001 08:37:04 -0500
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:24987 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S280689AbRKBNgx>; Fri, 2 Nov 2001 08:36:53 -0500
Message-ID: <3BE2A153.B9B06FD2@cisco.com>
Date: Fri, 02 Nov 2001 19:06:19 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: query about use of IFDEFS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

which of the following be acceptable  in the linux kernel ?

1. first choice, you've put the static inline in the header
---------------------------------------

foo.h:

#ifdef CONFIG_BAR
void foo_init(void);
#else
static void __inline__ foo_init(void);

foo.c:

#ifdef CONFIG_BAR

void foo_init(void)
{
    do_some_stuff_here();
}

#else
#endif

2. you've left the conditional compilation only in the .c file
----------------------------------------

foo.h:

void foo_init(void);

foo.c:

void foo_init (void)
{

#ifdef CONFIG_BAR
        do_some_stuff_here();
#else
#endif
}

