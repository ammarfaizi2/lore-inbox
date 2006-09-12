Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWILD5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWILD5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWILD5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:57:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:41179 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964987AbWILD5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:57:17 -0400
Date: Mon, 11 Sep 2006 20:37:00 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <eugeny.mints@gmail.com>,
       Matthew Locke <matt@nomadgs.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       pm list <linux-pm@lists.osdl.org>,
       Preece Scott-PREECE <scott.preece@motorola.com>,
       Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Message-ID: <20060912033700.GD27397@kroah.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz> <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com> <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912001701.GC14234@linux.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 05:17:01PM -0700, Mark Gross wrote:
> 
> cpufreq is broken at the cpufreq_driver interface for embedded
> applications needing control over more than one control variable at a
> time.
> 
> That interface only supports setting target frequencies, and expanding it
> to set target frequencies and voltages is not possible without something
> like PowerOP.  Adding the types of parameters to cpufreq would likely
> make cpufreq a mess.  I think we would be better off with something that
> coexists with cpufreq, like the powerop patch from Eugeny.
> 
> God help you if you try to use cpufreq on a complex non-PC platform with
> multiple power and clock domains that need to be tweaked to squeeze out
> competitive battery life.
> 
> Because of the existing user base of cpufreq removing cpufreq will never
> happen.  No one supporting the PowerOP patch has never recommended
> such a thing.  However; holding back innovation because of an existing
> solution that doesn't support a large class of users seems dumb.

But you can't break the existing stuff, and it seems that some of these
proposals are doing just that. :(

thanks,

greg k-h
