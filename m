Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRGVXnU>; Sun, 22 Jul 2001 19:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268101AbRGVXnL>; Sun, 22 Jul 2001 19:43:11 -0400
Received: from CPE-61-9-148-51.vic.bigpond.net.au ([61.9.148.51]:11765 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S268100AbRGVXnE>;
	Sun, 22 Jul 2001 19:43:04 -0400
Message-ID: <3B5B6311.C8F8094E@eyal.emu.id.au>
Date: Mon, 23 Jul 2001 09:34:41 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
In-Reply-To: <01071815464209.12129@starship> <3B58CBA3.BD2C194@compaq.com> <01072122255100.02679@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Daniel Phillips wrote:
> Yes, I tested almost all of them to see how well they worked my
> directory index application.  There are really only two criterea:
> 
>   1) How random is the hash
>   2) How efficient is it
> 
> My testing was hardly what you would call rigorous.  Basically, what I
> do is hash a lot of very unrandom strings and see how uniform the

Actually, to measure the randomness you need to measure the randomness
of
the output in the face of non-random input. Most well constructed hash
functions perform well when the strings are random, however real world
data (e.g. directory contntent) is not random at all.

Efficiency should measure both space and time resources. If it should
work in a multithreaded situation then another level of complexity is
added.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
