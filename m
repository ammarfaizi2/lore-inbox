Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313285AbSC1XJf>; Thu, 28 Mar 2002 18:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313286AbSC1XJX>; Thu, 28 Mar 2002 18:09:23 -0500
Received: from ns.suse.de ([213.95.15.193]:33291 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313285AbSC1XJG>;
	Thu, 28 Mar 2002 18:09:06 -0500
Date: Fri, 29 Mar 2002 00:09:04 +0100
From: Dave Jones <davej@suse.de>
To: Adam D Scislowicz <adams@fourelle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Model IDs(string) inconsistant on SMP AMD System (2.4.18-rc4)
Message-ID: <20020329000904.F5064@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adam D Scislowicz <adams@fourelle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CA37778.9090009@fourelle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 12:05:12PM -0800, Adam D Scislowicz wrote:
 > I am working with several SMP Athlon machines, and they are all 
 > reporting the first CPUs
 > model ID(*** called 'model name' in /proc/cpuinfo) as 'AMD Athlon(tm) MP 
 > 1800+' and the
 > second CPUs model ID as 'AMD Athlon(tm) Processor'.
 > 
 >  From looking at the code it seems that the model IDs are obtained using 
 > cpuid calls. Does
 > anyone have insight into this?

It means your BIOS vendor can't read specifications.

'AMD Athlon(tm) Processor'. is the power-on default.
On working out if the CPU is an XP or an MP (by reading the MP bit
in cpu capabilities flags) it's supposed to set the name string.
Crap BIOSen only do this for the first CPU.

It's harmless, but I'll get around to writing a boot time fixup
sometime.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
