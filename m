Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWABWWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWABWWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWABWWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:22:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:51898 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751077AbWABWWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:22:43 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <m1irt25pxg.fsf@ebiederm.dsl.xmission.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <m1irt25pxg.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Mon, 02 Jan 2006 14:22:38 -0800
Message-Id: <1136240558.20330.57.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-02 at 13:35 -0700, Eric W. Biederman wrote:

> I haven't looked closely enough at the state of the openib tree but
> you should not need an additional interface to send/receive standard
> IB subnet management packets.  That is something that should be provided
> the same way by all infiniband drivers.

We provide the standard OpenIB mechanisms for doing that, of course.
However, our driver is layered.  The OpenIB layer uses facilities
provided by the main driver (via ipath_layer.c).  The main driver can
stand alone, without the OpenIB code compiled into the kernel or
available as a module at all.  In that case, a userland subnet
management agent must still be able to send and receive management
packets.

> Given Linus's comments and looking at where you are getting stuck I
> would recommend you split out support for the nonstandard ipath
> protocol from the rest of the driver.

While we can split the main driver source file up along those lines, we
are not planning to make the ipath protocol optional.  We are planning
to submit another non-OpenIB network driver that depends on the ipath
protocol support.

	<b

