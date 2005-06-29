Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVF2XqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVF2XqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 19:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVF2XqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 19:46:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:24492 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262735AbVF2XqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:46:02 -0400
Subject: Re: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050629165828.GA73550@muc.de>
References: <20050628235848.GA6376@austin.ibm.com>
	 <1120009619.5133.228.camel@gaston> <20050629155954.GH28499@austin.ibm.com>
	 <20050629165828.GA73550@muc.de>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:40:07 +1000
Message-Id: <1120088407.31924.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 18:58 +0200, Andi Kleen wrote:
> > Yep, OK. Pushig the timer would in fact break if the device was marked
> > perm disabled.
> 
> I think for network drivers you should just write a generic error handler
> (perhaps in net/core/dev.c) that calls the watchdog handler. 
> Then all drivers could be easily converted without much code duplication.

Provided the watchdog timer completely reconfigures the device from
reset since the slot will be reset...

Ben.


