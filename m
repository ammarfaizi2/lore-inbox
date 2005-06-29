Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVF2XrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVF2XrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVF2XrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:47:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:28588 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262744AbVF2XrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:47:10 -0400
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050629204823.GM28499@austin.ibm.com>
References: <20050628235919.GA6415@austin.ibm.com>
	 <1120009868.5133.232.camel@gaston>  <20050629204823.GM28499@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:41:14 +1000
Message-Id: <1120088475.31924.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 15:48 -0500, Linas Vepstas wrote:

> > The only type of "synchronous" error checking that can be done is what
> > is proposed by Hidetoshi Seto. You could use his stuff here.
> 
> Yes. However, I will leave this bit in for now, (and mark it as a hack) 
> until Seto-san's patches are on deck. I'd rather not have a built-in 
> pre-req right now.

No, check for ff's where they don't make sense or add a timeout to the
loop. That's the correct solution for now.

Ben.


