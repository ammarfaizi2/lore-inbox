Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVLNV5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVLNV5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVLNV5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:57:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:29070 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932340AbVLNV5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:57:10 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: Sridhar Samudrala <sri@us.ibm.com>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <43A08546.8040708@superbug.co.uk>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
	 <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
	 <43A08546.8040708@superbug.co.uk>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 13:55:43 -0800
Message-Id: <1134597344.8855.1.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 20:49 +0000, James Courtier-Dutton wrote:
> Jesper Juhl wrote:
> > On 12/14/05, Sridhar Samudrala <sri@us.ibm.com> wrote:
> > 
> >>These set of patches provide a TCP/IP emergency communication mechanism that
> >>could be used to guarantee high priority communications over a critical socket
> >>to succeed even under very low memory conditions that last for a couple of
> >>minutes. It uses the critical page pool facility provided by Matt's patches
> >>that he posted recently on lkml.
> >>        http://lkml.org/lkml/2005/12/14/34/index.html
> >>
> >>This mechanism provides a new socket option SO_CRITICAL that can be used to
> >>mark a socket as critical. A critical connection used for emergency
> > 
> > 
> > So now everyone writing commercial apps for Linux are going to set
> > SO_CRITICAL on sockets in their apps so their apps can "survive better
> > under pressure than the competitors aps" and clueless programmers all
> > over are going to think "cool, with this I can make my app more
> > important than everyone elses, I'm going to use this".  When everyone
> > and his dog starts to set this, what's the point?
> > 
> > 
> 
> I don't think the initial patches that Matt did were intended for what 
> you are describing.
> When I had the conversation with Matt at KS, the problem we were trying 
> to solve was "Memory pressure with network attached swap space".
> I came up with the idea that I think Matt has implemented.
> Letting the OS choose which are "critical" TCP/IP sessions is fine. But 
> letting an application choose is a recipe for disaster.

We could easily add capable(CAP_NET_ADMIN) check to allow this option to
be set only by privileged users.

Thanks
Sridhar

