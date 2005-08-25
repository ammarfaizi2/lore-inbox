Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVHYXSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVHYXSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVHYXSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:18:12 -0400
Received: from ozlabs.org ([203.10.76.45]:57314 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964975AbVHYXSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:18:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17166.20904.543484.435446@cargo.ozlabs.ibm.com>
Date: Fri, 26 Aug 2005 09:18:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
In-Reply-To: <1125006237.12539.23.camel@gaston>
References: <20050823231817.829359000@bilge>
	<20050823232143.003048000@bilge>
	<20050823234747.GI18113@austin.ibm.com>
	<1124898331.24668.33.camel@sinatra.austin.ibm.com>
	<20050824162959.GC25174@austin.ibm.com>
	<17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	<1124930943.5159.168.camel@gaston>
	<20050825162118.GH25174@austin.ibm.com>
	<1125006237.12539.23.camel@gaston>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> Ok, so what is the problem then ? Why do we have to wait at all ? Why
> not just unplug/replug right away ?

We'd have to be absolutely certain that the driver could not possibly
take another interrupt or try to access the device on behalf of the
old instance of the device by the time it returned from the remove
function.  I'm not sure I'd trust most drivers that far...

Paul.
