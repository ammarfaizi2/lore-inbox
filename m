Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbRADEA5>; Wed, 3 Jan 2001 23:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132592AbRADEAs>; Wed, 3 Jan 2001 23:00:48 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:64767 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129324AbRADEAl>; Wed, 3 Jan 2001 23:00:41 -0500
Message-ID: <3A53F647.B39C9B5A@sympatico.ca>
Date: Wed, 03 Jan 2001 23:04:24 -0500
From: François Isabelle <isabellf@sympatico.ca>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-Prerelease :smp_num_cpus undefined while compiling without smp for 
 Athlon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in smp.h macro
#define smp_num_cpus
etc...
have no effect on the kernel_stat.h file .

if might be undefined or declared elsewhere as an int or such...I added
#define smp_test_num_cpus
and replaced the occurence in kernel_stat.h and it worked ok

and tried to find where the smp_num_cpus define was getting screwed...
no success.

this have the effect of unbuildable kernel with options: smp off and
athlon on, i don't know about other problematic configurations.
I have gcc version 2.96
and make 3.78.1

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
