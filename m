Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVLLWt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVLLWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 17:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLLWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 17:49:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:14252 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932192AbVLLWt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 17:49:26 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, anandhkrishnan@yahoo.com,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@redhat.com,
       greg@kroah.com
In-Reply-To: <20051212111322.40be4cfe.akpm@osdl.org>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <20051212111322.40be4cfe.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Dec 2005 22:48:32 +0000
Message-Id: <1134427712.10304.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-12 at 11:13 -0800, Andrew Morton wrote:
> Do we really need to do this at runtime?  We could check this when building
> module depoendencies (for example).  That'll be a 95% solution..

Its almost the 0% solution. The kernel as shipped doesn't seem to have
any clashing symbols like this. The two sets of cases people report are 

1. Out of tree modules
2. Reconfiguring, rebuilding something from kernel to module and not
cleaning up

A dep time solution might fix one of those but robustness here would be
good, especially as once the installation is incorrect end users can
often trigger hotplug loads that cause problems.


