Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTI3PNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbTI3PNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:13:36 -0400
Received: from [205.233.219.253] ([205.233.219.253]:48551 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S261590AbTI3PNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:13:34 -0400
Date: Tue, 30 Sep 2003 11:13:21 -0400
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930151321.GI17855@conscoop.ottawa.on.ca>
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030929220916.19c9c90d.davem@redhat.com> <1064903562.6154.160.camel@imladris.demon.co.uk> <20030930000302.3e1bf8bb.davem@redhat.com> <1064907572.21551.31.camel@hades.cambridge.redhat.com> <20030930010855.095c2c35.davem@redhat.com> <1064910398.21551.41.camel@hades.cambridge.redhat.com> <20030930013025.697c786e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930013025.697c786e.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Richard Guy Briggs <rgb@conscoop.ottawa.on.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 01:30:25AM -0700, David S. Miller wrote:
> On Tue, 30 Sep 2003 09:26:38 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > Why would he run 'make'? He'll only run 'make modules' since he only
> > enabled one extra module, and then he expects to be able to load it
> > without a reboot.
> 
> If 'make modules' doesn't check if the config change has hit a
> dependency that requires the core kernel image to be rebuilt, we need
> to fix that.  'make modules' depends upon the kernel image.

If a module depends on core kernel functionality, that module option
should not be visible in the config until the core kernel functionality
has been turned on.  Otherwise, maybe that core kernel functionality
should also be a module.

> At the very least, it should refuse to build the modules and tell the
> user what he needs to do first.

That would also work.

> All you've shown me is a bug in the build system, not a fundamental
> issue with module enables creating changes to the main kernel image.

	slainte mhath, RGB

-- 
Richard Guy Briggs           --    ~\                 Auto-Free Ottawa! Canada
<www.TriColour.net>            --    \@       @           <www.flora.org/afo/>
No Internet Wiretapping!        --   _\\/\%___\\/\%        Vote! -- <Green.ca>
<www.FreeSWAN.org>_______GTVS6#790__(*)_______(*)(*)_______<www.Marillion.com>
