Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUDPTQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUDPTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:16:12 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:31016 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263618AbUDPTQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:16:10 -0400
Date: Fri, 16 Apr 2004 21:24:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sipos Ferenc <sferi@mail.tvnet.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: off:latest binary nvidia driver won't compile with 2.6.6-rc1
Message-ID: <20040416192446.GA2697@mars.ravnborg.org>
Mail-Followup-To: Sipos Ferenc <sferi@mail.tvnet.hu>,
	Sam Ravnborg <sam@ravnborg.org>, lkml <linux-kernel@vger.kernel.org>
References: <1082061685.5837.2.camel@zeus.city.tvnet.hu> <20040415212923.GA2656@mars.ravnborg.org> <1082092808.2027.3.camel@zeus.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082092808.2027.3.camel@zeus.city.tvnet.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 07:20:08AM +0200, Sipos Ferenc wrote:
> Hi!
> 
> Something is wrong with your solution, because I'm building a monolithic
> kernel, so nvidia would be my only module. I have done make modules as
> you've said (I think a simple make does that also, so it wouldn't be
> required), and the Modules.synvers file doesn't exist. 2.6.5 works
> normally, only using nvidia as a module. Note that module support is
> compiled in the kernel.

The Module.symvers file is only generated if you have a minimum of one module
in the kernel. I'm in the process of fixing this.

Also the Modules.symvers file is not needed when CONFIG_MODVERSIONS are turned
off - so I will fix this also.

Thanks for the hint (monolithic kernel with module support enabled).

The workaround for now is just to declare a simple driver a module.
For example the dummy driver in the net section.

	Sam

