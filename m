Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbTEMXwS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTEMXwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:52:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32009 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263572AbTEMXwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:52:16 -0400
Date: Tue, 13 May 2003 17:00:36 -0700
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: alexander.riesen@synopsys.COM, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.5.69+bk: "irq 15: nobody cared!" on a Compaq Armada 1592DT
Message-Id: <20030513170036.7ad52da6.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0305131020070.5420-100000@montezuma.mastecende.com>
References: <20030513134907.GF32559@Synopsys.COM>
	<Pine.LNX.4.50.0305131020070.5420-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 00:04:58.0311 (UTC) FILETIME=[74EAA570:01C319AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> Bugger, this is due to yenta_probe_irq.
> 
> There really should be 'events' to handle unless... 
> Perhaps someone who knows yenta could best comment.

I think what we're going to do there is to just remove the darn warning. 
Only enable it when a special CONFIG_IRQ_DEBUG has been set.

So people can turn that on when they have specific problems.  Yes, it will
get false positives, but it should enable us to diagnose the source of
irq-related lockups amongst the noise.

So let's leave things as they are at present, and when we're satisfied that
most drivers are doing mostly the right thing, go add the config option.

