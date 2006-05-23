Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWEWH6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWEWH6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWEWH6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:58:23 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:64904 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751299AbWEWH6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:58:22 -0400
Message-ID: <4472BFE4.8000605@aitel.hist.no>
Date: Tue, 23 May 2006 09:55:16 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Matheus Izvekov <mizvekov@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520090614.GA9630@infradead.org> <20060520201357.GA32010@taniwha.stupidest.org> <20060520212049.GA11180@taniwha.stupidest.org> <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com> <Pine.LNX.4.61.0605220739580.26623@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605220739580.26623@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

>On ix86 there are not enough registers to pass a significant parameter
>list all in registers! Like when you are printk()ing a dotted-quad IP
>address, etc. Registers ESI, EDI, and EBX are precious, that leaves
>EAX, ECX, EDX and possibly EBP for only 4 parameters. You need 5
>for the dotted quad IP address. If the compiler were to use the
>precious registers, the contents need to be saved on the stack.
>That negates any advantage to passing parameters in registers.
>  
>
I had the impression that REGPARM in i386 only passed the
first three arguments in registers, putting any further
paramters on the stack? 

Ought to help for all those 3-argument or less functions.

Helge Hafting
