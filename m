Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVF2DCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVF2DCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVF2DCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:02:40 -0400
Received: from colin.muc.de ([193.149.48.1]:33287 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261267AbVF2DCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:02:38 -0400
Date: 29 Jun 2005 05:02:37 +0200
Date: Wed, 29 Jun 2005 05:02:37 +0200
From: Andi Kleen <ak@muc.de>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
Message-ID: <20050629030237.GB71992@muc.de>
References: <20050628235919.GA6415@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628235919.GA6415@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 06:59:19PM -0500, Linas Vepstas wrote:
> 
> pci-err-7-symbios.patch
> 
> Adds PCI Error recoervy callbacks to the Symbios Sym53c8xx driver.
> Tested, seems to work well under i/o stress to one disk. Not
> stress tested under heavy i/o to multiple scsi devices.

What does this do to the IO requests currently being processed
by the firmware? Do they get all aborted? Is it ensured
that they all error out properly? 

-Andi
