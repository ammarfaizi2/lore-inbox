Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbSJRE2v>; Fri, 18 Oct 2002 00:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbSJRE2u>; Fri, 18 Oct 2002 00:28:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32506 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262892AbSJRE2t>;
	Fri, 18 Oct 2002 00:28:49 -0400
Subject: [RFC] linux-2.5.34_vsyscall_A0 - Test App
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>
Cc: Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       george anzinger <george@mvista.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1034915132.1681.144.camel@cog>
References: <1034915132.1681.144.camel@cog>
Content-Type: multipart/mixed; boundary="=-TTzN78fr2Wu1BLKnV04W"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Oct 2002 21:26:27 -0700
Message-Id: <1034915187.2209.147.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TTzN78fr2Wu1BLKnV04W
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

All,
	Attached is a application to test vsyscall_A0 gettimeofday.

thanks
-john



--=-TTzN78fr2Wu1BLKnV04W
Content-Disposition: attachment; filename=vsyscall-test.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=vsyscall-test.c; charset=ISO-8859-1

#include <stdio.h>
#include <stdlib.h>

void (*vsys)(struct timeval*, struct timeval*) =3D (void*)0xffffe000UL;
void main()
{
	struct timeval tv;
	gettimeofday(&tv,NULL);
	printf("time:  %lu %lu\n", tv.tv_sec,tv.tv_usec);
	(*vsys)(&tv,NULL);
	printf("vtime: %lu %lu\n", tv.tv_sec,tv.tv_usec);
=09
}

--=-TTzN78fr2Wu1BLKnV04W--

