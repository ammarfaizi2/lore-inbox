Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWG2Mvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWG2Mvt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWG2Mvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:51:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8526 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932131AbWG2Mvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:51:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lCxbtW6NwXOEeikGPU2yT/7M6jw+AWuZPH+R9h72HzV++prr8rU+RK+tmb5ZXPxAY8tlR5yZlffeSBzIc1XYZmxhtYJt6z0LKygYrW5UEg5nwpo/4rSuRVSKaf/V2Ya/XCq0XtlHgbdLHos9NJs08eDHxGLIM8SaB06DGuKHeSg=
Message-ID: <41840b750607290551kae4a7c7k9402c96e5b67e6a5@mail.gmail.com>
Date: Sat, 29 Jul 2006 15:51:45 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Henrique de Moraes Holschuh" <hmh@debian.org>
In-Reply-To: <20060729120411.GA8285@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
	 <41840b750607280814x50db03erb30d833802ae983e@mail.gmail.com>
	 <20060728202359.GB5313@suse.cz>
	 <41840b750607281548h5ee2219eka1de6745b692c092@mail.gmail.com>
	 <20060729103613.GB7438@suse.cz>
	 <41840b750607290432m6d302cdoae7f3eef869279d4@mail.gmail.com>
	 <20060729120411.GA8285@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > I think what people want from device choice is a reasonable default
> > plus a convenient way to override things. The former is handled nicely
> > by distributions' udev rules, while the latter is best done by
> > providing fixed paths. As an end-user, if I know my favorite joystick
> > is on a specific USB port (hence a specific syfs directory), then I
> > want to tell neverball "use that one" without setting up nasty udev
> > rules or playing major:minor matchup. Yes, that's bypassing the Proper
> > Udevian Way of Doing Things, but it's so much easier and Unix-like
> > that we really should make it possible (though not by default!).
>
> IMO the right way here would be to have a nice GUI for configuring udev
> included with the distro, that'd let you browse the sysfs tree and
> point'n'click to create the rule you need.

That's still an extra level of indirection. You have to use the nice
GUI to create a new /dev/something, and then point your at at dev
/dev/something. And you have to be root to do that, whereas some sysfs
stuff is world-readable.


> > Security issues aside (for a moment):
> > Is there any reason not to provide real device inodes on sysfs,
> > instead of just a textual /sys/foo/dev? And then, maybe udev should
> > symlink to those device files under /sys instead of creating its own?
> > This would tie the two systems together rather elegantly.
>
> The reason behind this was to force people NOT use sysfs directly when
> interfacing to the OS. ;)
>
> Because sysfs wasn't intended to be an API you can rely on, one that's
> fixed in stone and cannot be changed for compatibility reasons. I
> believe it failed in that respect.

Is sysfs supposed to be a private" API that only "special services
services" look at? It has definitely failed in this respect -- It's
just too convenient and attractive. I'm not sure that's a bad thing...

Given the current usage pattern of sysfs, is it still a bad idea for
it to carry device inodes?

  Shem
