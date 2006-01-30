Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWA3XA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWA3XA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWA3XA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 18:00:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50379 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S965019AbWA3XAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 18:00:25 -0500
Subject: PCI layer: Need for enable/disable counting (was  disable PCI
	device if it is enabled	before probing)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43DE6A06.9030707@shadowconnect.com>
References: <43D566DB.2010103@shadowconnect.com>
	 <1138645069.31089.79.camel@localhost.localdomain>
	 <43DE6A06.9030707@shadowconnect.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jan 2006 23:01:09 +0000
Message-Id: <1138662069.31089.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-30 at 20:33 +0100, Markus Lidel wrote:
> I've searched for a function enabled() or so, but didn't find anything. 
> Could you tell me the right way to do it normally?

Right now there isn't one. I've hit this problem with the new libata
layer stuff having successfully disabled my root pci bridge on unload at
least once.

Would be easy to add one but I suspect it should be rcounted so that
enable/disable just stack naturally ?

What do people want from such an interface and should it also start boot
enabled devices at a count of 1 or just the bridges/video class
devices ?

Alan

