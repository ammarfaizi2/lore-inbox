Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSKJJYY>; Sun, 10 Nov 2002 04:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264768AbSKJJYY>; Sun, 10 Nov 2002 04:24:24 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:34264 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264767AbSKJJYX>; Sun, 10 Nov 2002 04:24:23 -0500
Date: Sun, 10 Nov 2002 10:27:34 +0100
From: Dominik Brodowski <linux@brodo.de>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: torvalds@transmeta.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5. PATCH] cpufreq: correct initialization on Intel Copperm ines
Message-ID: <20021110102733.A1029@brodo.de>
References: <A46BBDB345A7D5118EC90002A5072C7807B7E080@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7807B7E080@orsmsx116.jf.intel.com>; from inaky.perez-gonzalez@intel.com on Sat, Nov 09, 2002 at 04:54:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Nov 09, 2002 at 04:54:27PM -0800, Perez-Gonzalez, Inaky wrote:
> > [2.5. PATCH] cpufreq: Intel Coppermines -- the saga continues.
> > 
> > The detection process for speedstep-enabled Pentium III Coppermines is
> > considered proprietary by Intel. The attempt to detect this
> > capability using MSRs failed. So, users need to pass the option
> > "speedstep_coppermine=1" to the kernel (boot option or parameter) if
> > they own a SpeedStep capable PIII Coppermine processor. Tualatins work
> > as before.
> 
> Cannot you use ACPI to detect that? AFAIK, if the machine supports it, it is
> doable.

Most PIII Coppermine notebooks only have ACPI 1.x which does not include
"Performance States" - an interface to Intel SpeedStep and other, similar 
technologies. And when there is a working "Performance States" support in
ACPI, this itself registered as cpufreq driver and then there's no need for 
the legacy speedstep driver. So, no, unfortunately your suggestion doesn't 
solve the problem.

	Dominik
