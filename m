Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264351AbTCUXwU>; Fri, 21 Mar 2003 18:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264352AbTCUXwT>; Fri, 21 Mar 2003 18:52:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39432 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264351AbTCUXwT>;
	Fri, 21 Mar 2003 18:52:19 -0500
Date: Fri, 21 Mar 2003 16:03:23 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Message-ID: <20030322000323.GC18010@kroah.com>
References: <20030321014048.A19537@baldur.yggdrasil.com> <3E7B79D5.3060903@cox.net> <20030321232131.GA18010@kroah.com> <3E7BA329.2060806@cox.net> <3E7BA618.3060603@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7BA618.3060603@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 11:54:00PM +0000, Andrew Walrond wrote:
> Sounds wonderful. Any downsides?

It's not implemented yet :)

Seriously, there are a few gotchas that need to be worked out
(serialization of hotplug events, ordering, and other races), and a few
security issues to be addressed.  Oh, and we need to finish converting
all of the kernel's drivers to export their major/minor number through
sysfs to get this to work.

Just a few minor things left...

thanks,

greg k-h
