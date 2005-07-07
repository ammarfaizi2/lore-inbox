Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVGGW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVGGW3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGGW2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:28:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:60303 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262233AbVGGW2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:28:01 -0400
Subject: Re: [PATCH 2.6.13-rc1 01/10] IOCHK interface for I/O error
	handling/detecting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20050707184102.GC14726@kroah.com>
References: <42CB63B2.6000505@jp.fujitsu.com>
	 <20050707184102.GC14726@kroah.com>
Content-Type: text/plain
Date: Fri, 08 Jul 2005 08:27:18 +1000
Message-Id: <1120775239.31924.262.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 11:41 -0700, Greg KH wrote:
> On Wed, Jul 06, 2005 at 01:53:06PM +0900, Hidetoshi Seto wrote:
> > Hi all,
> > 
> > The followings are updated version of patches I've posted to
> > implement IOCHK interface for I/O error handling/detecting.
> > 
> > The abstraction of patches hasn't changed, so please refer
> > archives if you need, e.g.: http://lwn.net/Articles/139240/
> 
> How about the issue of tying this into the other pci error reporting
> infrastructure that is being worked on?

The other infrastructure is for asynchronous reporting and recovery. We
still need synchronous detection & reporting. So this is a bit
different.

However, it would be nice if Hidetoshi's work could be adapted a bit so
that 1) naming is a bit more consistent with the other stuff (pcierr_*
maybe) and 2) the error "token" is the same. The later is especially
important if we start adding ways to query the error token to know what
the error precisely was etc... There is no reason to have 2 different
ways of representing error details.

Ben


