Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUCQTcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUCQTcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:32:20 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48145 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261999AbUCQTcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:32:16 -0500
Date: Wed, 17 Mar 2004 19:32:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <20040317193206.A17987@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-raid@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4058A481.3020505@pobox.com>; from jgarzik@pobox.com on Wed, Mar 17, 2004 at 02:18:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 02:18:25PM -0500, Jeff Garzik wrote:
> > 	o Allow fully pluggable meta-data modules
> 
> yep, needed

Well, this is pretty much the EVMS route we all heavily argued against.
Most of the metadata shouldn't be visible in the kernel at all.

> > 	o Improve the ability of MD to auto-configure arrays.
> 
> hmmmm.  Maybe in my language this means "improve ability for low-level 
> drivers to communicate RAID support to upper layers"?

I think he's talking about the deprecated raid autorun feature.  Again
something that is completely misplaced in the kernel.  (ågain EVMS light)

> > 	o Support multi-level arrays transparently yet allow
> > 	  proper event notification across levels when the
> > 	  topology is known to MD.
> 
> I'll need to see the code to understand what this means, much less 
> whether it is needed ;-)

I think he mean the broken inter-driver raid stacking mentioned below.
Why do I have to thing of EVMS when for each feature?..

