Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUHEPlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUHEPlA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267711AbUHEPlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:41:00 -0400
Received: from palrel10.hp.com ([156.153.255.245]:36766 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267702AbUHEPkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:40:49 -0400
Date: Thu, 5 Aug 2004 08:39:29 -0700
From: Grant Grundler <iod00d@hp.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Grant Grundler <iod00d@hp.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-ia64@vger.kernel.org, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: [Fastboot] Re: [BROKEN PATCH] kexec for ia64
Message-ID: <20040805153929.GC6526@cup.hp.com>
References: <200407261524.40804.jbarnes@engr.sgi.com> <200407261536.05133.jbarnes@engr.sgi.com> <20040730155504.2a51b1fa.rddunlap@osdl.org> <m18ycvhx1j.fsf@ebiederm.dsl.xmission.com> <20040804233335.GD548@cup.hp.com> <m1hdri2uw0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hdri2uw0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 08:14:55PM -0600, Eric W. Biederman wrote:
> VGA/serial console devices rarely need to do be bus masters so they
> should be fine.

yeah - you are right. I wasn't thinking.
Can anyone comment on UGA or other console devices?

> In the general case it appears to be overkill, incorrect and
> insufficient to disable bus mastering on all PCI devices.  Which is
> why device_shutdown() calls device specific code.

Is anyone else considering using kexec() to recover from a oops/panic?
What is the risk calling multiple device_shutdown() will expose another panic?

While calling a device specific cleanup is best, I worry about how
much code/data gets touched in this path. I was hoping something
simple like twiddling bus master bit would be sufficient.
If it's not, oh well.

thanks,
grant
