Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWEWUAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWEWUAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWEWUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:00:37 -0400
Received: from main.gmane.org ([80.91.229.2]:50130 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751218AbWEWUAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:00:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Jones <adam@yggdrasl.demon.co.uk>
Subject: Re: kernel: padlock: VIA PadLock not detected.
Date: Tue, 23 May 2006 20:41:19 +0100
Message-ID: <adam.20060523194119$0db7@samael.haus>
References: <20060523164634.GC9829@dantooine>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: yggdrasl.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a futile gesture against entropy, markus reichelt wrote:

> I get the following message on a Nehemiah system. Any ideas about
> that?

> kernel: CPU0: Centaur VIA Nehemiah stepping 01
> kernel: padlock: VIA PadLock not detected
> 
> cat /proc/cpuinfo
[...]
> flags           : fpu de tsc msr cx8 mtrr pge cmov mmx fxsr sse
> fxsr_opt

I believe the padlock support was only added in later steppings of the
Nehemiah core.  My Nehemiah system here supports it:

cat /proc/cpuinfo 
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 8
cpu MHz         : 997.000
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep mtrr pge cmov pat mmx fxsr sse rng rng_en ace ace_en
bogomips        : 2007.25

(Note the rng* and ace* flags)

According to a VIA press release here:
http://www.linuxdevices.com/sponsors/SP2782600871-NS4520757633.html
only stepping 8 or later CPUs support these instructions.
-- 
Adam Jones (adam@yggdrasl.demon.co.uk)(http://www.yggdrasl.demon.co.uk/)
.oO("It's not like it's sigfile fodder or anything..."                 )
PGP public key: http://www.yggdrasl.demon.co.uk/pubkey.asc

