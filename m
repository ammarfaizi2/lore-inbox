Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTFREER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 00:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFREER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 00:04:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62623 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265069AbTFREEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 00:04:16 -0400
Date: Wed, 18 Jun 2003 05:18:11 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Alan Stern'" <stern@rowland.harvard.edu>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>, "'Greg KH'" <greg@kroah.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030618041811.GY6754@parcelfarce.linux.theplanet.co.uk>
References: <A46BBDB345A7D5118EC90002A5072C780DD16A41@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16A41@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 08:44:50PM -0700, Perez-Gonzalez, Inaky wrote:

> Maybe this is going to kill my argument as an analogy, but think
> about a C++ class hierarchy, where belonging to a class means
> to inherit that class' methods. When an object is instantiated
> and its class inherits a lot of other classes, it inherits all
> the methods of those classes. Your methods are the attrs, and
> you can access them with the same pointer, you don't  need to
> look somewhere else ...

But there is no inheritance here.  Block device and IDE disk are
different objects and relation is not "A is B with <...>", it's
"among other things, A happens to use B in a way <...>".  

Moreover, there is no such thing as "physical device of that block device".
There might be many.  There might be none.  IOW, we have a bunch of
constructors for class "block device" and some of them happen to have
some kinds of physical devices among their arguments.  That's it.
