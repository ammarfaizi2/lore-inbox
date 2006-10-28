Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWJ1Szg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWJ1Szg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWJ1Szg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:55:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54032 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932092AbWJ1Szf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:55:35 -0400
Date: Sat, 28 Oct 2006 18:55:13 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Zeuthen <davidz@redhat.com>
Cc: Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028185513.GD5152@ucw.cz>
References: <1161710328.17816.10.camel@hughsie-laptop> <1161762158.27622.72.camel@shinybook.infradead.org> <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com> <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162048148.2723.61.camel@zelda.fubar.dk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Hm. Again we have the question of whether to export 'threshold_pct'
> > > vs.'threshold_abs', or whether to have a separate string property
> > > which says what the 'unit' of the threshold is. I don't care much --
> > > I'll do whatever DavidZ prefers.
> > 
> > Unit is easier to process in HAL in my opinion.
> 
> What about just prepending the unit to the 'threshold' file? Then user
> space can expect the contents of said file to be of the form "%d %s". I
> don't think that violates the "only one value per file" sysfs mantra.

Bad idea... I bet someone will just ignore the units part, because all
the machines he seen had mW there. Just put it into the name:

power_avg_mV

							Pavel

-- 
Thanks for all the (sleeping) penguins.
