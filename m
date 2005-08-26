Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVHZU2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVHZU2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbVHZU2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:28:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030258AbVHZU2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:28:02 -0400
Date: Fri, 26 Aug 2005 16:27:33 -0400
From: Dave Jones <davej@redhat.com>
To: Robert Love <rml@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Message-ID: <20050826202733.GA26003@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Robert Love <rml@novell.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Brian Gerst <bgerst@didntduck.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1125069494.18155.27.camel@betsy> <430F5257.4010700@didntduck.org> <1125077594.18155.52.camel@betsy> <1125079311.4294.10.camel@laptopd505.fenrus.org> <1125079430.18155.64.camel@betsy> <1125086134.14080.13.camel@localhost.localdomain> <1125084555.18155.89.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125084555.18155.89.camel@betsy>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 03:29:15PM -0400, Robert Love wrote:
 > On Fri, 2005-08-26 at 20:55 +0100, Alan Cox wrote:
 > 
 > > I think that should be fixed before its merged.
 > 
 > Let me be clear, it has an init routine that effectively probes for the
 > device.
 > 
 > It just lacks a simple quick non-invasive check.
 > 
 > The driver will definitely fail to load on a laptop without the
 > requisite hardware.

Poking IO ports on hardware where you don't have the device
can be fatal.  What happens if I have something completely different
at io port 0x1600 ? (Thus satisfying your request_region() check).
accelerometer_init() then happily starts poking ports, and performing
all kinds of voodoo.

		Dave

