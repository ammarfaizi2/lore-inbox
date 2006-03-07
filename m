Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWCGFGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWCGFGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCGFGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:06:41 -0500
Received: from fmr19.intel.com ([134.134.136.18]:37581 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750708AbWCGFGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:06:40 -0500
Date: Tue, 7 Mar 2006 13:06:09 +0800
From: Wang Zhenyu <zhenyu.z.wang@intel.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       thayne@realmsys.com
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Message-ID: <20060307050609.GA32733@zhen-devel.sh.intel.com>
Mail-Followup-To: Dave Peterson <dsp@llnl.gov>,
	Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
	thayne@realmsys.com
References: <200603031047.01445.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603031047.01445.dsp@llnl.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.03.04 02:47:01 +0000, Dave Peterson wrote:
> 
>    On Thursday 02 March 2006 18:30, Andrew Morton wrote:
>    > Dave Peterson <dsp@llnl.gov> wrote:
>    > >  +#ifdef CORRECT_BIOS
>    > >  +fail0:
>    > >  +#endif
>    >
>    > What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
>    > commentary?  ;)
>    I'm not sure about this.  I'm cc'ing Thayne Harbaugh and Wang Zhenyu since
>    their names are in the credits for the i82875p module.  Maybe they can
>    provide some info.

You can take CORRECT_BIOS as "strict-pci-resource-reserve" for overflow device
in 82875p, some bad BIOS does make it reserved, which cause pci_request_region()
failed.  Actually we never defined it. 

zhen
