Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263595AbRFSVAA>; Tue, 19 Jun 2001 17:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263596AbRFSU7k>; Tue, 19 Jun 2001 16:59:40 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:46861 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S263595AbRFSU72>;
	Tue, 19 Jun 2001 16:59:28 -0400
Message-ID: <20010619205926.5459.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
Subject: Re: [SMP] 2.4.5-ac13 memory corruption/deadlock?
To: glamm@mail.ece.umn.edu (Bob Glamm)
Date: Tue, 19 Jun 101 15:59:26 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010619135310.A15004@kittpeak.ece.umn.edu> from "Bob Glamm" at Jun 19, 1 01:53:10 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure about bad memory?

Single-bit errors will be corrected; double-bit errors will generate NMI.
You can also find memory errors with an exerciser.  Unfortunately,
trusty memtest86 bombs on my ServerWorks machine.  Instead I use

	http://www.qcc.sk.ca/~charlesc/software/memtester/

which runs in user-mode.  I diagnosed thermal problems by running
this utility.  Within 3 minutes of cold start, it raised main memory
temperature sufficiently to induce a hard error, which was detected
simultaneously by it and the hardware (NMI taken by kernel).

Can you recommend one of your (shorter) tests for me to try?
