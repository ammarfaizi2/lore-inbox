Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWAEP2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWAEP2u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAEP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:28:50 -0500
Received: from mx.pathscale.com ([64.160.42.68]:21962 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932076AbWAEP2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:28:49 -0500
Subject: Re: [PATCH 0 of 20] [RFC] ipath - PathScale InfiniPath driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adawthf4rc0.fsf@cisco.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <20051230080002.GA7438@kroah.com>
	 <1135984304.13318.50.camel@serpentine.pathscale.com>
	 <20051231001051.GB20314@kroah.com>
	 <1135993250.13318.94.camel@serpentine.pathscale.com>
	 <m1irt25pxg.fsf@ebiederm.dsl.xmission.com>  <adawthf4rc0.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 05 Jan 2006 07:28:48 -0800
Message-Id: <1136474928.31922.14.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 13:26 -0800, Roland Dreier wrote:

> Yes, this might be a good idea.  The "core" driver looks like it is
> suffering from really being several things stuck together.

Yes, this is undoubtedly the case; we developed it organically based on
our evolving needs, and we're only now (maybe a bit belatedly) stepping
back to take a breath and see how things should be logically split out.

> Also, there are APIs in the "core" driver that are only exported for a
> single user outside the driver -- it would probably make sense to move
> that logic directly to where it's used.

Right.  The purpose of the whole ipath_layer.c file has perhaps been
unclear; we've been holding back a network driver that makes use of it,
to keep the size of the review patches down.  Some of the other
verbs-related routines in the core driver are in the process of finding
a new home, as you suggested.

As ever, thanks for the comments.

	<b

