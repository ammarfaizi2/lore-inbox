Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTIIXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTIIXQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:16:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:2441 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265200AbTIIXQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:16:24 -0400
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review"
	needs explaining to you?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309091604070.695-100000@cherise>
References: <Pine.LNX.4.44.0309091604070.695-100000@cherise>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063149303.31269.30.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 00:15:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 00:07, Patrick Mochel wrote:
> What about suspend-to-ram, APM, and runtime states? 
> 
> That actually makes it quite a bit more complicated, globally. By forcing 
> the policy down to the drivers, you force each one to interpret the value 
> themselves and make the decision. By doing it centrally, the only thing 
> the low-level drivers have to worry about is going into the state. 

APM and ACPI suspend/resume (especially resume) are different. Very
different with some hardware in fact. For IDE to be done perfectly you
want to know if its ACPI S4 or APM suspend. The driver needs to be able
to get the actual aim but most I agree wont care which.

