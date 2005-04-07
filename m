Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVDGHqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVDGHqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDGHqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:46:06 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:48828 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261997AbVDGHpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:45:52 -0400
Date: Thu, 7 Apr 2005 01:47:50 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Magnus Damm <magnus.damm@gmail.com>
cc: Malcolm Rowe <malcolm-linux@farside.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2
In-Reply-To: <aec7e5c305040615146766e121@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504070142190.12823@montezuma.fsmlabs.com>
References: <20050405225747.15125.8087.59570@clementine.local> 
 <courier.4253BAD7.000018D2@mail.farside.org.uk>  <aec7e5c305040606104c86712c@mail.gmail.com>
  <courier.4253F216.00001A20@mail.farside.org.uk> <aec7e5c305040615146766e121@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Magnus Damm wrote:

> On Apr 6, 2005 4:28 PM, Malcolm Rowe <malcolm-linux@farside.org.uk> wrote:
> > Magnus Damm writes:
> > > And I guess the idea of replacing the initcall pointer with NULL will
> > > work both with and without function descriptors, right? So we should
> > > be safe on IA64 and PPC64.
> > 
> > I think so, though I don't really know a great deal about this area.
> > 
> > An IA64 descriptor is of the form { &code, &data_context }, and a function
> > pointer is a pointer to such a descriptor. Presumably, setting a function
> > pointer to NULL will either end up setting the pointer-to-descriptor to NULL
> > or the code pointer to NULL, but either way, I would expect the 'if
> > (!*call)' comparison to work as intended.
> > 
> > Best thing would be to get someone on IA64 and/or PPC64 to check this for
> > you. 
> 
> I agree. Do we have any friendly IA64/PPC64 user out there?

In C code it is consistent across all architectures, you only have to 
worry about the descriptors when you do modifications in assembly.

	Zwane

