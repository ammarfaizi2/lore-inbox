Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUA1Oyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 09:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUA1Oyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 09:54:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43019 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265979AbUA1Oyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 09:54:43 -0500
Date: Wed, 28 Jan 2004 14:54:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
       Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org, mj@ucw.cz,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040128145441.A28889@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
	"Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, greg@kroah.com,
	Andi Kleen <ak@colin2.muc.de>, akpm@osdl.org, mj@ucw.cz,
	"Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <6B09584CC3D2124DB45C3B592414FA83011A336E@bgsmsx402.gar.corp.intel.com> <4017CA6C.1070301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4017CA6C.1070301@intel.com>; from vladimir.kondratiev@intel.com on Wed, Jan 28, 2004 at 04:42:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 04:42:52PM +0200, Vladimir Kondratiev wrote:
> My inputs:
> 
> - I do not like pci_express_read implemented as inline function. It is 
> called only in one place. It is more appropriate, on my opinion, to 
> merge all stuff added to include/asm-i386/pci.h , into 
> arch/i386/pci/direct.c.

Actually it should be in a file of it's own, e.g. arch/i386/pci/express.c

