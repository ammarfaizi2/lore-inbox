Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVBHM1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVBHM1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 07:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVBHM1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 07:27:42 -0500
Received: from gizmo05bw.bigpond.com ([144.140.70.40]:55750 "HELO
	gizmo05bw.bigpond.com") by vger.kernel.org with SMTP
	id S261522AbVBHM1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 07:27:36 -0500
From: pageexec@freemail.hu
To: Ingo Molnar <mingo@elte.hu>
Date: Tue, 08 Feb 2005 22:27:19 +1000
MIME-Version: 1.0
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Reply-to: pageexec@freemail.hu
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Message-ID: <42093CC7.5086.1FC83D3E@localhost>
In-reply-to: <20050207223609.GA12609@elte.hu>
References: <42080689.15768.1B0C5E5F@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> btw., do you consider PaX as a 100% sure solution against 'code
> injection' attacks (meaning that the attacker wants to execute an
> arbitrary piece of code, and assuming the attacked application has a
> stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
> way?

your question is answered in http://pax.grsecurity.net/docs/pax.txt
that i suggested you to read over a year ago. the short answer is
that it's not only about stack overflows but any kind of memory
corruption bugs, and you need both a properly configured kernel
(for PaX/i386 that would be SEGMEXEC/MPROTECT/NOELFRELOCS) and an
access control system (to take care of the file system and file
mappings) and a properly prepared userland (e.g., no text relocations
in ELF executables/libs, which is a good thing anyway).

