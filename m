Return-Path: <linux-kernel-owner+w=401wt.eu-S1750929AbXACQ4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbXACQ4L (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXACQ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:56:11 -0500
Received: from outbound-mail-33.bluehost.com ([69.89.18.153]:33498 "HELO
	outbound-mail-33.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750936AbXACQ4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:56:10 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 11:56:10 EST
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] quiet MMCONFIG related printks
Date: Wed, 3 Jan 2007 08:49:32 -0800
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200701012101.38427.jbarnes@virtuousgeek.org> <1167832386.3095.20.camel@laptopd505.fenrus.org>
In-Reply-To: <1167832386.3095.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701030849.33205.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 67.161.73.10 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 3, 2007 5:53 am, Arjan van de Ven wrote:
> On Mon, 2007-01-01 at 21:01 -0800, Jesse Barnes wrote:
> > Using MMCONFIG for PCI config space access is simply an
> > optimization, not a requirement.  Therefore, when it can't be used,
> > there's no need for KERN_ERR level message.  This patch makes the
> > message a KERN_INFO instead to reduce some of the noise in a kernel
> > boot with the 'quiet' option. (Note that this has no effect on a
> > normal boot, which is ridiculously verbose these days.)
>
> this is wrong, please leave this loud complaint in...

So the issues as I understand them:
  o some BIOSes are broken and don't properly map MCFG space (though
    according to Petr V. reserving MCFG space in e820 is optional, so
    the test may be slightly wrong as-is)
  o MCFG space is required for (many) PCIe devices (any regular PCI
    devices?)
  o often, there's nothing the user can do to address the points above

So where does that leave us?  I've got what I consider to be a stupid 
error message in my log.  My system behavior isn't affected in any way 
(at least that I can tell), yet I get a loud complaint at boot time.

I guess I just have to live with it?

Thanks,
Jesse

