Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUBYLll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbUBYLll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:41:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:13494 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261268AbUBYLlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:41:40 -0500
Subject: Re: new driver (hvcs) review request and sysfs questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Dave Boutcher <sleddog@us.ibm.com>, Ryan Arnold <rsa@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, boutcher@us.ibm.com,
       Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20040225042224.GA5135@kroah.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com>
	 <20040225012845.GA3909@kroah.com> <opr3woijnwl6e53g@us.ibm.com>
	 <20040225042224.GA5135@kroah.com>
Content-Type: text/plain
Message-Id: <1077708874.22213.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 22:34:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 15:22, Greg KH wrote:
> On Tue, Feb 24, 2004 at 09:12:09PM -0600, Dave Boutcher wrote:
> > 
> > It is also true that it is unlike the representation of most other things 
> > in sysfs, so perhaps this is the time to change before it gets too baked 
> > into things.
> 
> I agree.  Is there any reason we _have_ to stick with the OF names?  It
> seems to me to make more sense here not to, to make it more like the
> rest of the kernel.
> 
> That is, if the address after the @ is unique.  Is that always the case?

That is the problem... I didn't check my OF spec, but I do remember
clearly cases where the "unit address" isn't unique... This happens
typically at the root of the device-tree, or with pseudo devices,
where you can have several entries with an @0 unit address. However,
I yet have to see that for things that are worth putting into sysfs ;)

One thing though is that it's only unique at a given level of
hierarchy. The Unit Address in OF has no meaning outside of the
context of the parent bus. That may be just fine for sysfs, but
if I take as an example the PCI devices, they do have a globally
unique ID here with the domain number.

Ben.


