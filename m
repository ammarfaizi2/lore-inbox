Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422912AbWJaH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbWJaH4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422913AbWJaH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:56:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:48579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422912AbWJaH4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:56:38 -0500
Date: Mon, 30 Oct 2006 23:49:46 -0800
From: Greg KH <greg@kroah.com>
To: Shem Multinymous <multinymous@gmail.com>
Cc: David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061031074946.GA7906@kroah.com>
References: <1161762158.27622.72.camel@shinybook.infradead.org> <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com> <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 08:12:41PM +0200, Shem Multinymous wrote:
> Hi David,
> 
> On 10/28/06, David Zeuthen <davidz@redhat.com> wrote:
> >What about just prepending the unit to the 'threshold' file? Then user
> >space can expect the contents of said file to be of the form "%d %s". I
> >don't think that violates the "only one value per file" sysfs mantra.
> 
> The tp_smapi battery driver did just this  ("16495 mW"). But I dropped
> it in a recent version when Pavel pointed out the rest of sysfs, hwmon
> included, uses undecorated integers.
> Consistency aside, it seems reasonable and convenient. You have to
> decree that writes to the attributes (where relevant) don't include
> the units, of course, so no one will expect the kernel to parse that.
> 
> There's an issue here if a drunk driver decides to specify (say)
> capacity_remaining in mWh and capacity_last_full in mAa, which will
> confuse anyone comparing those attributest. So don't do that.
> 
> Jean, what's your opinion on letting hwmon-ish attributes specify
> units as "%d %s" where these are hardware-dependent?

No, the sysfs files should just always keep the same units as
documented.  It's easier all around that way.

thanks,

greg k-h
