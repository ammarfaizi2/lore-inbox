Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUKBSwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUKBSwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUKBSwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:52:17 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:60364 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261323AbUKBSwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:52:13 -0500
Date: Tue, 2 Nov 2004 10:52:12 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Marc Bevand <bevand_m@epita.fr>, linux-kernel@vger.kernel.org
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
In-Reply-To: <200411020854.21629.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.61.0411021049510.6586@twinlark.arctic.org>
References: <cm4moc$c7t$1@sea.gmane.org> <Pine.LNX.4.61.0411011233203.8483@twinlark.arctic.org>
 <200411020854.21629.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Denis Vlasenko wrote:

> On Monday 01 November 2004 22:44, dean gaudet wrote:
> > note that 
> > p4 would prefer "sub $1, %r11b" here instead of dec... but the difference 
> > is likely minimal.
> 
> p4 is not the only x86 CPU on the planet. Why should I use
> longer instruction then?

you're asking about spending one byte?  one byte extra for code which 
could perform better on more CPUs?

i could equally well say "k8 is not the only x86-64 cpu on the planet".

i really don't care whether this change is made or not, i only mentioned a 
general perf rule.

go ahead and use -Os for the rest of the kernel if you're worried about 
size, it'll likely go faster.  but spending 1 byte in code which is perf 
critical is nothing.

-dean
