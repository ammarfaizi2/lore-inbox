Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRE3Ulg>; Wed, 30 May 2001 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbRE3Ul0>; Wed, 30 May 2001 16:41:26 -0400
Received: from mercury.ukc.ac.uk ([129.12.21.10]:58540 "EHLO mercury.ukc.ac.uk")
	by vger.kernel.org with ESMTP id <S262094AbRE3UlU>;
	Wed, 30 May 2001 16:41:20 -0400
Date: Wed, 30 May 2001 21:40:45 +0100 (BST)
From: Leonid Timochouk <L.A.Timochouk@ukc.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Segfault during network calls
Message-ID: <Pine.GSO.4.21.0105302124290.10349-100000@myrtle.ukc.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello colleagues,

We have a strange problem with our multi-threaded SMTP client: at very
heavy load (e.g. 150 threads, each with a pool of 5 persistent
connections) it sometimes receives SIGSEGV while making network kernel
calls (mostly in "recvfrom" for both TCP and UDP, but also in "connect").
This happens for both 2.2.12 and 2.4.4 kernels on a Celeron 600 machine
(no SMP) with glibc 2.1.3. The kernel logs do not show any problems, yet
the application program gets killed. This happens MORE frequently if we
increase the number of file descriptors available to the process (using
"ulimit -n"), which suggests some resource utilisation problem in the
kernel (?) E.g., is there a compiled-in upper bound on the total number of
sockets which can be created by all processes? (I could not find
SOCK_ARRAY_SIZE in 2.4.4). Any ideas would be very much appreciated.

Thank you very much in advance,

Dr. Leonid A. Timochouk
Computing Laboratory
University of Kent at Canterbury

