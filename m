Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVGRTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVGRTQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGRTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 15:16:37 -0400
Received: from colo.lackof.org ([198.49.126.79]:39831 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261525AbVGRTQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 15:16:35 -0400
Date: Mon, 18 Jul 2005 13:21:16 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 05/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050718192116.GB11016@colo.lackof.org>
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB680E.2010103@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CB680E.2010103@jp.fujitsu.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:11:42PM +0900, Hidetoshi Seto wrote:
> [This is 5 of 10 patches, "iochk-05-check_bridge.patch"]
...
>   It means that A or B hits a bus error, but there is no data
>   which one actually hits the error. So, C should notify the
>   error to both of A and B, and clear the H's status to start
>   its own I/Os.
> 
>   If there are only two devices, it become more simple. It is
>   clear if one find a bridge error while another is check-in,
>   the error is nothing except for another's.

Sorry, I don't understand this last paragraph.
I don't see how it's more simple with two devices (vs three) if
we don't exactly know which device caused the error. I thought
one still needed to reset/restart both devices. Is that correct?

The devices operate asyncronously from the drivers.
Only the driver can tell us for sure if IO was in flight for a
particular device and decide that a device could NOT have generated
an error.


Otherwise, so far, the patches look fine to me.

thanks,
grant
