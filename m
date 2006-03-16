Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWCPXr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWCPXr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWCPXr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 18:47:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:49340
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751227AbWCPXrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 18:47:25 -0500
Date: Thu, 16 Mar 2006 15:47:05 -0800
From: Greg KH <gregkh@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Cc: Mark Maule <maule@sgi.com>, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, shaohua.li@intel.com
Subject: Re: [PATCH] (-mm) drivers/pci/msi: explicit declaration of msi_register
Message-ID: <20060316234705.GA24527@suse.de>
References: <44172F0E.6070708@ce.jp.nec.com> <20060314134535.72eb7243.akpm@osdl.org> <44176502.9050109@ce.jp.nec.com> <20060315235544.GA6504@suse.de> <44198210.6090109@ce.jp.nec.com> <20060316181934.GM13666@sgi.com> <4419BD64.5070705@ce.jp.nec.com> <20060316194155.GP13666@sgi.com> <20060316232837.GA12408@suse.de> <adalkvaneq5.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adalkvaneq5.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 03:37:22PM -0800, Roland Dreier wrote:
>     Greg> As msi.c today is pretty platform-specific as is, I don't
>     Greg> have a problem with moving the ia64 stuff also into that
>     Greg> directory.  Especially as it will help solve issues like
>     Greg> this a lot better.
> 
> I think we really want to make drivers/pci/msi.c less
> platform-specific.  Both powerpc and sparc64 are starting to pay
> attention to MSI, so we should really be trying to move things in the
> direction of a clean separation of generic MSI handling and
> Intel-specific bits.

Oh I completely agree.  It's just that the efforts so far to do this has
caused a big #include mess that we are currently in.  And I don't think
that putting pci core structures in the include/linux/ directory is the
correct solution.  If others can come up with cleaner splits of the
code, I incourage it.

thanks,

greg k-h
