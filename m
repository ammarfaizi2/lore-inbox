Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933257AbWKSUsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933257AbWKSUsQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933263AbWKSUsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:48:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:27047 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933257AbWKSUsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:48:15 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <4560C23D.6080304@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <4560BDF5.400@ru.mvista.com>
	 <1163968376.5826.110.camel@localhost.localdomain>
	 <4560C121.30403@ru.mvista.com>  <4560C23D.6080304@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:48:09 +1100
Message-Id: <1163969289.5826.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     Sorry, it's the same for x86 version of OpenPIC according to spec. I meant 
> the PPC implementation here.

Same OpenPIC.. it can deal with both INTACK cycles and reading from an
INTACK register. On some PPC's, we actually have logic in the bridge to
generate the INTACK cycle (which exist on PCI) though we only use that
with 8259's currently as it's not really more efficient than just
reading from the INTACK register of the OpenPIC.

Ben.


