Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUAKDjU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbUAKDjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:39:19 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:64392 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265746AbUAKDjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:39:18 -0500
Message-ID: <4000C544.1040301@cyberone.com.au>
Date: Sun, 11 Jan 2004 14:38:44 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
CC: linux-kernel@vger.kernel.org, Ethan Weinstein <lists@stinkfoot.org>
Subject: Re: 2.6.1 and irq balancing
References: <40008745.4070109@stinkfoot.org> <200401102139.09883.edt@aei.ca>
In-Reply-To: <200401102139.09883.edt@aei.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ed Tomlinson wrote:

>Hi,
>
>What is the load on the box when this is happening?  If its low think
>this is optimal (for cache reasons).
>  
>

I'd rather see different interrupt sources run on different CPUs
initially, which would help fairness a little bit, and should be
more optimal with big interrupt loads.


0:      xxx1     0      0      0
1:      0     xxx2      0      0
2:      0        0   xxx3      0
3:      0        0      0   xxx4

This would delay the need for interrupt balancing in the case where
2 or more interrupts are heavily used.


