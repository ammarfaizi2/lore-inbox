Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270075AbRHWTDZ>; Thu, 23 Aug 2001 15:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270042AbRHWTDP>; Thu, 23 Aug 2001 15:03:15 -0400
Received: from jason05.u.washington.edu ([140.142.8.54]:55263 "EHLO
	jason05.u.washington.edu") by vger.kernel.org with ESMTP
	id <S270011AbRHWTDG>; Thu, 23 Aug 2001 15:03:06 -0400
Date: Thu, 23 Aug 2001 12:03:21 -0700 (PDT)
From: "J. Imlay" <jimlay@u.washington.edu>
To: <linux-kernel@vger.kernel.org>
Subject: macro conflict
Message-ID: <Pine.A41.4.33.0108231150110.64144-100000@dante14.u.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IN getting the AFS kernel modules to compile under linux I dicovered that
the were useing the standard min(x,y) macro that whould evaluate which one
is smaller. However sometime between 2.4.6 and 2.4.9 a new macro was added
to linux/kernel.h

this one:

#define min(type,x,y) \
        ({ type __x = (x), __y = (y); __x < __y ? __x: __y; })

the old one is

#define min(x,y) ( (x)<(y)?(x):(y) )

has been around a lot longer and is in lots of header files.

The problem here with AFS is that it needs the old definition but the old
definition is being over written by the new one... you guys should know
all this. But I am just saying that I really think the new macro
min(type,x,y) should get a new name. like type_min or something.

Thanks,

Josie Imlay

