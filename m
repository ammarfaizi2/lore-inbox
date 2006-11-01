Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992756AbWKATdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992756AbWKATdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992754AbWKATdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:33:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:41168 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992755AbWKATda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:33:30 -0500
Date: Wed, 1 Nov 2006 11:30:14 -0800
From: Greg KH <greg@kroah.com>
To: Richard Hughes <hughsient@gmail.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Jean Delvare <khali@linux-fr.org>, davidz@redhat.com,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101193014.GA29929@kroah.com>
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <6DP6m926.1162281579.9733640.khali@localhost> <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com> <1162302686.31012.47.camel@frg-rhel40-em64t-03> <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com> <1162387577.5001.7.camel@hughsie-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162387577.5001.7.camel@hughsie-laptop>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:26:17PM +0000, Richard Hughes wrote:
> On Tue, 2006-10-31 at 16:06 +0200, Shem Multinymous wrote:
> > 
> > In the case at hand we have mWh and mAh, which measure different
> > physical quantities. You can't convert between them unless you have
> > intimate knowledge of the battery's chemistry and condition, which we
> > don't.
> 
> I'm thinking specifically for ACPI at the moment.
> 
> When ACPI can't work out a value, i.e. it's not known, it returns a
> value of 0xFFFFFFFF. This can happen either for a split second on
> disconnect, or if the hardware really doesn't know the value.
> 
> With the battery class driver, how would that be conveyed? Would the
> sysfs file be deleted in this case, or would the value of the sysfs key
> be something like "<invalid>".

No, the sysfs file should just not be present.

thanks,

greg k-h
