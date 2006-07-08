Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbWGHVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbWGHVFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWGHVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:05:30 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:16876 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1030382AbWGHVF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:05:28 -0400
Date: Sat, 8 Jul 2006 18:09:26 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060708180926.00b1c0f8@home.brethil>
In-Reply-To: <20060708064131.GG4188@suse.de>
References: <20060707070703.165520@gmx.net>
	<20060707040749.97f8c1fc.akpm@osdl.org>
	<20060707131310.0e382585@doriath.conectiva>
	<20060708064131.GG4188@suse.de>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Jens,

On Sat, 8 Jul 2006 08:41:32 +0200
Jens Axboe <axboe@suse.de> wrote:

| On Fri, Jul 07 2006, Luiz Fernando N. Capitulino wrote:
| > On Fri, 7 Jul 2006 04:07:49 -0700
| > Andrew Morton <akpm@osdl.org> wrote:
| > 
| > | On Fri, 07 Jul 2006 09:07:03 +0200
| > | "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
| > | 
| > | > c) Occasionally the command line just hangs, producing no output.
| > | >    In this case I can't kill it with ^C or ^\.  This is a 
| > | >    hard-to-reproduce behaviour on my (x86) system, but I have 
| > | >    seen it several times by now.
| > | 
| > | aka local DoS.  Please capture sysrq-T output next time.
| > 
| >  If I run lots of them in parallel, I get the following OOPs in a few
| > seconds:
| 
| With the patch posted? You need the i vs nrbufs fix.

 Yes, it fixes the problem. I didn't try it before because I thought
you were going to double check it [1].

 Is it suitable for -stable then?

[1] http://lkml.org/lkml/2006/7/7/158

-- 
Luiz Fernando N. Capitulino
