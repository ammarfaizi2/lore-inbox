Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbRFLSZV>; Tue, 12 Jun 2001 14:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbRFLSZL>; Tue, 12 Jun 2001 14:25:11 -0400
Received: from gene.pbi.nrc.ca ([204.83.147.150]:27954 "EHLO gene.pbi.nrc.ca")
	by vger.kernel.org with ESMTP id <S263003AbRFLSZF>;
	Tue, 12 Jun 2001 14:25:05 -0400
Date: Tue, 12 Jun 2001 12:24:04 -0600 (CST)
From: <ognen@gene.pbi.nrc.ca>
To: <linux-kernel@vger.kernel.org>
Subject: threading question
Message-ID: <Pine.LNX.4.30.0106121213570.24593-100000@gene.pbi.nrc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am a summer student implementing a multi-threaded version of a very
popular bioinformatics tool. So far it compiles and runs without problems
(as far as I can tell ;) on Linux 2.2.x, Sun Solaris, SGI IRIX and Compaq
OSF/1 running on Alpha. I have ran a lot of timing tests compared to the
sequential version of the tool on all of these machines (most of them are
dual-CPU, although I am also running tests on 12-CPU Solaris and 108 CPU
SGI IRIX). On dual-CPU machines the speedups are as follows: my version
is 1.88 faster than the sequential one on IRIX, 1.81 times on Solaris,
1.8 times on OSF/1, 1.43 times on Linux 2.2.x and 1.52 times on Linux 2.4
kernel. Why are the numbers on Linux machines so much lower? It is the
same multi-threaded code, I am not using any tricks, the code basically
uses PTHREAD_CREATE_DETACHED and PTHREAD_SCOPE_SYSTEM and the thread stack
size is set to 8K (but the numbers are the same with larger/smaller stack
sizes).

Is there anything I am missing? Is this to be expected due to Linux way of
handling threads (clone call)? I am just trying to explain the numbers and
nothing else comes to mind....

Best regards,
Ognen Duzlevski
-- 
ognen@gene.pbi.nrc.ca
Plant Biotechnology Institute
National Research Council of Canada
Bioinformatics team

