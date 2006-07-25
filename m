Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWGYPGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWGYPGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWGYPGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:06:11 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:59487 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932411AbWGYPGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:06:10 -0400
Date: Tue, 25 Jul 2006 17:06:07 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060725150606.GA8566@harddisk-recovery.com>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 05:59:23PM -0700, Linus Torvalds wrote:
> On Mon, 24 Jul 2006, Chuck Ebbert wrote:
> > 
> > I thought just the 'ondemand' governor was a problem?
> 
> The ondemand governor seems to be singled out not because it has unique 
> problems, but because it seems to be used by Fedora Core for some strange 
> reason.
> 
> I would judge that any bugs in cpufreq_ondemand.c are likely equally 
> evident in cpufreq_conservative.c, for example. I think the two have the 
> same background, and seem to have the same broken locking.

The "conservative" governor switches less often, so the locking
condition just happens less often.

After some strange lockups with 2.6.18-rc* I switched from "ondemand"
to "conservative" and now my laptop survives the night. Sheer luck, I
guess. I'd rather switch to "powersave" or "performance".


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
