Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTLVXEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTLVXEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:04:15 -0500
Received: from [193.138.115.2] ([193.138.115.2]:58372 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264559AbTLVXEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:04:12 -0500
Date: Tue, 23 Dec 2003 00:01:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: SCO's infringing files list
In-Reply-To: <1072125736.1286.170.camel@duergar>
Message-ID: <Pine.LNX.4.56.0312222353310.27724@jju_lnx.backbone.dif.dk>
References: <1072125736.1286.170.camel@duergar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One thing I noticed.

I'm looking at include/signal.h from linux-0.01 and the definition of the
signal() function, the prototype in include/signal.h is

void (*signal(int _sig, void (*_func)(int)))(int);

I then take a look in my copy of UNIX Network Programming by W. Richard
Stevens from 1990, and notice that he on page 46 says this :

"...
A process specifies how it wants a signal handled by calling the signal
system call.

#include <signal.h>

int (*signal (int sig, void (*func)(int)))(int);

..."


The return type here is "int" while Linus originally made the return type
"void". If Linus had copied signal.h from UNIX the return type would have
been "int"...

