Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTFLNOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTFLNOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:14:07 -0400
Received: from AMarseille-201-1-3-129.w193-253.abo.wanadoo.fr ([193.253.250.129]:8487
	"EHLO gaston") by vger.kernel.org with ESMTP id S264786AbTFLNOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:14:06 -0400
Subject: Re: pci_domain_nr vs. /sys/devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
In-Reply-To: <20030612003715.GA1942@krispykreme>
References: <1055341842.754.3.camel@gaston>
	 <20030612003715.GA1942@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055424466.793.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jun 2003 15:27:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 02:37, Anton Blanchard wrote:
>  > So we can pave the way for when we'll stop play bus number tricks and
> > actually have overlapping PCI bus numbers between domains. (I don't plan
> > to do that immediately because that would break userland & /proc/bus/pci
> > backward compatiblity)
> 
> As davem suggested, /proc/bus/pci should present domain 0 in the old
> format even with pci domains enabled. If your graphics card is on domain
> 0 then X continues to work :)

Hrm... On most pmacs, it is, since domain 0 is the AGP port. Though
people with an additional PCI video card will not be happy. But X will
be fixed, so....

Ben.
