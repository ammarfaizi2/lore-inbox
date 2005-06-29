Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVF2RDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVF2RDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVF2RAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:00:40 -0400
Received: from colin.muc.de ([193.149.48.1]:13063 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262613AbVF2Q6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:58:30 -0400
Date: 29 Jun 2005 18:58:29 +0200
Date: Wed, 29 Jun 2005 18:58:29 +0200
From: Andi Kleen <ak@muc.de>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 4/13]: PCI Err: e100 ethernet driver recovery
Message-ID: <20050629165828.GA73550@muc.de>
References: <20050628235848.GA6376@austin.ibm.com> <1120009619.5133.228.camel@gaston> <20050629155954.GH28499@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629155954.GH28499@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep, OK. Pushig the timer would in fact break if the device was marked
> perm disabled.

I think for network drivers you should just write a generic error handler
(perhaps in net/core/dev.c) that calls the watchdog handler. 
Then all drivers could be easily converted without much code duplication.

-Andi
