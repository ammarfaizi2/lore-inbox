Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312708AbSCVPUQ>; Fri, 22 Mar 2002 10:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312711AbSCVPT7>; Fri, 22 Mar 2002 10:19:59 -0500
Received: from s99eagle01.okdhs.org ([204.87.68.21]:29205 "HELO
	dhshost.okdhs.org") by vger.kernel.org with SMTP id <S312708AbSCVPTl>;
	Fri, 22 Mar 2002 10:19:41 -0500
Message-ID: <E7B0663E34409F45B77EFDB62AE0E4D2022360BD@s99mail02.okdhs.org>
From: "Little, John" <JOHN.LITTLE@okdhs.org>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: fork() DoS?
Date: Fri, 22 Mar 2002 09:16:00 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really not a programmer, just learning, but was able to bring the system
to it's knees.  This is a redhat 7.2 kernel.  Is there anyway of preventing
this?

#include <unistd.h>

void do_fork()
{
   pid_t p;

   p = fork();
   do_fork();
}

void main()
{
   for(;;)
      do_fork();
}

