Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUDOARc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 20:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUDOARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 20:17:32 -0400
Received: from fmr99.intel.com ([192.55.52.32]:19605 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262370AbUDOAR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 20:17:29 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
Cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       ross@datscreative.com.au
In-Reply-To: <200404142157.34502.christian.kroener@tu-harburg.de>
References: <200404131117.31306.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404141502.14023.ross@datscreative.com.au>
	 <200404142157.34502.christian.kroener@tu-harburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1081988224.15062.75.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Apr 2004 20:17:05 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 15:57, Christian Kröner wrote:

> This is simply great, any uncommon hi-load disappeared.
> Will something like this get into mainline soon, maybe with automatic chipset 
> detection?

I'm okay putting the bootparam and the workaround into the kernel,
for it is generic and we may find other platforms need it.

But I don't have a clean way to make it automatic.
This is a BIOS bug, so chipset ID will not always work.

We could list the BIOS in dmi_scan(), but I hate doing
that b/c then the vendor releases a new version of their
broken BIOS and the automatic workaround no longer works...

-Len


