Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWAYWqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWAYWqp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWAYWqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:46:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:10125 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932184AbWAYWqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:46:44 -0500
Subject: Re: [Perfctr-devel] RE: [perfmon] Re: quick overview of the
	perfmon2 interface
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, perfmon@napali.hpl.hp.com,
       "Eranian, Stephane" <stephane.eranian@hp.com>,
       Andrew Morton <akpm@osdl.org>, "Truong, Dan" <dan.truong@hp.com>
In-Reply-To: <20060125222844.GB10451@frankl.hpl.hp.com>
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net>
	 <1138221212.15295.35.camel@serpentine.pathscale.com>
	 <20060125222844.GB10451@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 14:46:43 -0800
Message-Id: <1138229203.15295.65.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 14:28 -0800, Stephane Eranian wrote:

> So it would help if you could
> name the extended features you referring to. 

I'm dubious about the hands-off buffer format in general.  Does this
mean that userspace needs to modprobe a specific set of modules in order
to do normal sampling?  If so, how do you work around the need for users
to be root in order to use these interfaces?

> And perfmon
> does allow it to continue working using almost all of its kernel code.
> This is leveraging the custom sampling buffer format support in perfmon.
> So you can say this is an extended feature that adds complexity.
> But OTOH, this is one elegant way of supporting an existing interface
> without breaking all the tools.

So are you saying that part of the existing oprofile code can be deleted
if perfmon is merged, and that userspace won't notice?

> We were able to proide this support
> with a few hundred lines of code without hacking the regular sampling
> format. Instead we simply created a dedicated PEBS format as a kernel module.

Does this mean I can't sample the PMCs on a P4 if I don't have the
special PEBS module loaded?  Do I need to be root to do that?

	<b

