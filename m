Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVJYAjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVJYAjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 20:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVJYAjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 20:39:31 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:29649
	"HELO linuxace.com") by vger.kernel.org with SMTP id S1751350AbVJYAja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 20:39:30 -0400
Date: Mon, 24 Oct 2005 17:39:29 -0700
From: Phil Oester <kernel@linuxace.com>
To: "Fao, Sean" <sean@capitalgenomix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 SMP Changes?
Message-ID: <20051025003929.GA4970@linuxace.com>
References: <435D786C.4000706@capitalgenomix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435D786C.4000706@capitalgenomix.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 07:12:28PM -0500, Fao, Sean wrote:
> Hello group,
> 
> Have any major changes been made to the SMP code between 2.6.10 and 
> 2.6.13?  After upgrading, it appears that either my two hyper-threaded 
> CPU's are running on a single thread, one of my processors is no longer 
> working or something is eating up 100% of the CPU time on the second 
> processor.  I used to see four CPU's in top and htop.  top now shows two 
> processors while htop shows four with processors three and four running 
> at 100% all the time.  I'm having a difficult time determining which 
> ones are the real CPU's and which are the hyper-threads.  Sorting by CPU 
> shows nothing using any more CPU than I would expect (most everything is 
> sitting idle).

ACPI was made dependent upon CONFIG_PM in 2.6.13, where it was not before.
So a "make oldconfig" in 2.6.13 against a 2.6.10 .config which had ACPI
enabled will end up disabling ACPI.

Interestingly, SMT used to work without ACPI, but now does not seem to
work without it.

Not sure if either of the above have been addressed in 2.6.14...haven't
had a chance to test

Phil
