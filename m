Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTFJQJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFJQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:09:48 -0400
Received: from angband.namesys.com ([212.16.7.85]:56500 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263322AbTFJQJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:09:47 -0400
Date: Tue, 10 Jun 2003 20:23:28 +0400
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030610162328.GA2637@namesys.com>
References: <20030605181423.GA17277@alpha.home.local> <20030608131901.7cadf9ea.skraw@ithnet.com> <20030608134901.363ebe42.skraw@ithnet.com> <20030609171011.7f940545.skraw@ithnet.com> <Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com> <20030610123015.4242716e.skraw@ithnet.com> <Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com> <20030610153815.57f7a563.skraw@ithnet.com> <Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com> <20030610175506.27f3a669.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610175506.27f3a669.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Jun 10, 2003 at 05:55:06PM +0200, Stephan von Krawczynski wrote:

> Jun 10 17:50:53 admin kernel: Process tar (pid: 4004, stackpage=dead5000)

Hehe, whith this kind of stackpage, this process was doomed just after the fork() ;)

> >>EIP; c0221c37 <st_do_scsi+127/180>   <=====

It seems that in st_do_scsi, in this line
                (STp->buffer)->syscall_result = st_chk_result(STp, SRpnt);

STp is garbage for some reason, though it was valid before.

Bye,
    Oleg
