Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWAMGbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWAMGbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 01:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWAMGbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 01:31:43 -0500
Received: from relay4.usu.ru ([194.226.235.39]:7388 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1751511AbWAMGbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 01:31:42 -0500
Message-ID: <43C74983.7070500@ums.usu.ru>
Date: Fri, 13 Jan 2006 11:32:35 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dmitry.torokhov@gmail.com
Subject: Re: linux-2.6.15-git7: PS/2 keyboard dies on ppp traffic
References: <43C66E82.4030106@ums.usu.ru>
In-Reply-To: <43C66E82.4030106@ums.usu.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.0.27; VDF: 6.33.0.118; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Hello,
> 
> the main linux tree started suffering the same bug as described for -mm 
> earlier in http://lkml.org/lkml/2005/11/7/147:
> 
> if I put load on my system, connect to the Internet using my cellphone 
> (/dev/ttyS0) and do something, it stops reacting to PS/2 keyboard 
> events, but still understands PS/2 mouse. The PPP load monitor shows 
> huge transfer rate (several megabytes per second) consisting of the 
> infinitely replicated several last packets. events/0 consumes all the 
> CPU. tty buffering revamping patch is the obvious candidate, but I 
> haven't tried to revert it yet.

As an experiment, I applied all tty layer buffering revamping patched 
from 2.6.15-mm2 to the vanilla 2.6.15. There were two rejects in drivers 
that I don't even compile, I ignored them. The bug indeed manifested 
itself. There is no such bug in vanilla 2.6.15 kernel.

So please, remove these broken patches from mainline and give me some 
instructions how to debug this in -mm.

-- 
Alexander E. Patrakov
