Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275213AbTHGMJf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275249AbTHGMJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:09:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:46978 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275213AbTHGMJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:09:34 -0400
Subject: Re: [Q] How can I transfer data from hard disk to PCI device's
	memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <005a01c35ca7$210f71e0$a5a5f88f@core8fyzomwjks>
References: <005a01c35ca7$210f71e0$a5a5f88f@core8fyzomwjks>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060257946.3123.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 13:05:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 06:45, Cho, joon-woo wrote:
> Hello.
> 
> I want to transfer data 'directly' from hard disk to some PCI device which
> has memory
> 
> with the helpf of kernel(file system, device driver).

The kernel doesn;t currently support this. The O_DIRECT I/O handling
needs to know about stuff like page reference counts that PCI space
doesn't have lots of older (and some current) hardware has real problems
with PCI PCI transfers.


So its a non trivial project, although doable

