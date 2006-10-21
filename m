Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992759AbWJUBpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992759AbWJUBpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWJUBpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:45:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:64909 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751104AbWJUBpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:45:10 -0400
Subject: Re: [Cbe-oss-dev] Correct way to format spufs file output.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dwayne Grant McConnell <decimal@us.ibm.com>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <200610201638.52404.arnd@arndb.de>
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug>
	 <200610201023.12796.arnd@arndb.de>
	 <Pine.WNT.4.64.0610200848580.5976@dwayne>
	 <200610201638.52404.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 11:44:53 +1000
Message-Id: <1161395093.10524.225.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-20 at 16:38 +0200, Arnd Bergmann wrote:
> On Friday 20 October 2006 15:54, Dwayne Grant McConnell wrote:
> > I think %0xllx is the way to go. I would even advocate changing 
> > signal1_type and signal2_type unless it is actually too dangerous.
> 
> There is absolutely no reason why these should be hexadecimal, they
> are basically implementing a bool.
> 
> > Is there even a case where changing from %llu to %0xllx would break things? 
> > Perhaps with the combination of a old library with a new kernel?
> 
> Right, a library or some script that has been written assuming there
> is no leading 0x.

We might still want to "broadcast" that we might change that and see how
much gets broken. It's very likely that nothing will.

Ben.


