Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWBFNmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWBFNmk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWBFNmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:42:39 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:49037 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932100AbWBFNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:42:38 -0500
Subject: Re: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
From: Arjan van de Ven <arjan@infradead.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1139203471.4641.41.camel@localhost>
References: <20060202041543.GA6755@RAM>
	 <1139085087.3131.8.camel@laptopd505.fenrus.org>
	 <1139203471.4641.41.camel@localhost>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 14:42:36 +0100
Message-Id: <1139233357.3131.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 21:24 -0800, Ram Pai wrote:
> On Sat, 2006-02-04 at 21:31 +0100, Arjan van de Ven wrote:
> > On Wed, 2006-02-01 at 20:15 -0800, Ram Pai wrote:
> > > Currently genksym does not take into account the GPLness of the exported
> > > symbol while generating the crc for the exported symbol. Any symbol
> > > changes from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL would not reflect in the
> > > Module.symvers file.  This patch fixes that problem.
> > 
> > and this is a problem.. why?
> 
> Tools that depend on Module.symvers wont be able to detect the change in
> GPLness of the exported symbols.

and that is relevant.. why?


> Eventually we want to generate a tool that can report API changes across
> kernel releases and put it in some friendly(docbook) format.

but a _GPL change isn't an API change though... either a module is legal
or it isn't. _GPL doesn't matter there...



