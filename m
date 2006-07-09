Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWGIKds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWGIKds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 06:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbWGIKdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 06:33:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13918 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030446AbWGIKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 06:33:47 -0400
Date: Sun, 9 Jul 2006 12:36:07 +0200
From: Jens Axboe <axboe@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060709103606.GU4188@suse.de>
References: <20060707070703.165520@gmx.net> <20060707040749.97f8c1fc.akpm@osdl.org> <20060707131310.0e382585@doriath.conectiva> <20060708064131.GG4188@suse.de> <20060708180926.00b1c0f8@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708180926.00b1c0f8@home.brethil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08 2006, Luiz Fernando N. Capitulino wrote:
> 
>  Hi Jens,
> 
> On Sat, 8 Jul 2006 08:41:32 +0200
> Jens Axboe <axboe@suse.de> wrote:
> 
> | On Fri, Jul 07 2006, Luiz Fernando N. Capitulino wrote:
> | > On Fri, 7 Jul 2006 04:07:49 -0700
> | > Andrew Morton <akpm@osdl.org> wrote:
> | > 
> | > | On Fri, 07 Jul 2006 09:07:03 +0200
> | > | "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
> | > | 
> | > | > c) Occasionally the command line just hangs, producing no output.
> | > | >    In this case I can't kill it with ^C or ^\.  This is a 
> | > | >    hard-to-reproduce behaviour on my (x86) system, but I have 
> | > | >    seen it several times by now.
> | > | 
> | > | aka local DoS.  Please capture sysrq-T output next time.
> | > 
> | >  If I run lots of them in parallel, I get the following OOPs in a few
> | > seconds:
> | 
> | With the patch posted? You need the i vs nrbufs fix.
> 
>  Yes, it fixes the problem. I didn't try it before because I thought
> you were going to double check it [1].

Yeah the patch needs reworking, however the isolated i vs nrbufs fix is
safe enough on its own. I'll post a full patch for inclusion, I'm afraid
I wont be able to fully test it enough for submitting it until tomorrow
though.

-- 
Jens Axboe

