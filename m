Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268686AbUIQKwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268686AbUIQKwD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268690AbUIQKwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:52:02 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:51211 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268672AbUIQKsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:48:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Fri, 17 Sep 2004 12:01:15 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua> <20040916121747.GQ9106@holomorphy.com>
In-Reply-To: <20040916121747.GQ9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409171201.15158.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 15:17, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >> As for all syscalls/etc. being slower by 50%-100%, I suggest toning
>
> On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> > s/all/many/:
> > uname <0.000142> ? ? ? ? ? ? ? uname <0.000217>		25% slower
> > brk <0.000176> ? ? ? ? ? ? ? ? brk <0.000174>		no change
> > open <0.000218> ? ? ? ? ? ? ? ?open <0.000335>		33% slower
> > fstat64 <0.000104> ? ? ? ? ? ? fstat64 <0.000191>	90% slower
> > or maybe strace simply isn't very accurate and adds signinficant
> > noise to the measured delta?
>
> Could you try to estimate the resolution of whatever timer strace uses?
>
> At some point in the past, I wrote:
> >> down HZ (we desperately need to go tickless) and seeing if it persists.
> >> Also please check that time isn't twice as fast as it should be in 2.6.
>
> On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> > I recompiled 2.6 with HZ=100. It's not it.
> > Time is running normally too.
>
> Did the kallsyms patches reduce the cpu overhead from get_wchan()?

Yes. top does not hog CPU anymore. It takes even a liitle bit *less*
CPU than in 2.4 now.
--
vda

