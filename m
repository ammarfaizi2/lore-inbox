Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTLBDA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 22:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLBDA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 22:00:26 -0500
Received: from mra03.ex.eclipse.net.uk ([212.104.129.88]:32946 "EHLO
	mra03.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S264282AbTLBDAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 22:00:22 -0500
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Missing L2-cache after warm boot
Date: Tue, 2 Dec 2003 03:00:11 +0000
User-Agent: KMail/1.5.4
References: <87ptf8bpnd.fsf@echidna.jochen.org>
In-Reply-To: <87ptf8bpnd.fsf@echidna.jochen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312020300.13067.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Dec 2003 14:04, Jochen Hein wrote:
> I'm running 2.6.0-test11 on an older Thinkpad 390E,
> When booting into 2.6.0-test11 after running Windows2000 I get:

Do any of the previous test releases show this problem?  How are you booting  
Linux?  Full warm boot via the BIOS or some loadlin kind of boot?  If it's 
via the BIOS then does that show the L2 cache as being present?

> When booting cold the boot messages are:

Presumably from switch on.

> /proc/cpuinfo contains (after warm boot):
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 6
> model name      : Mobile Pentium II
> stepping        : 10
> cpu MHz         : 298.598
> cache size      : 256 KB

And shows as 0 after warm boot?

> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat pse36 mmx fxsr bogomips        : 587.77
>
> Is there any way to find out, why the second level cache isn't
> detected after a warm boot?

My immediate thought was a BIOS problem.  IBM's web site doesn't say any BIOS 
updates fix L2 cache related problems, but then it doesn't seem to use 
technical descriptions like that.  It says the latest BIOS is 1.55 - R01_C9.

http://www-1.ibm.com/support/docview.wss?rs=0&uid=psg1MIGR-4F3VKB&loc=en_US

Or maybe it's possible that something in MS Windows 2000 is turning off the L2 
cache and it isn't getting reactivated by the warm boot?  What happens when 
you do a cold boot to Linux then reboot from there?

-- 
Ian.

