Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbUKCNDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbUKCNDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKCNDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:03:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:61959 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261588AbUKCNDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:03:30 -0500
Subject: Re: How to ship binary proprietary modules?
From: Arjan van de Ven <arjan@infradead.org>
To: Arne Henrichsen <ahenric@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <605a56ed041103045027f52b73@mail.gmail.com>
References: <605a56ed041103045027f52b73@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099487001.2813.20.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 03 Nov 2004 14:03:21 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 14:50 +0200, Arne Henrichsen wrote:
> Hi,
> 
> I would like to get some clarification on how to ship binary
> proprietary modules.
> 

First of all you should really talk to your lawyer about if and how you
can do this legally.

> I did compile my module under linux 2.6.8.1. and loaded it under
> 2.6.9. From what I understand of versioning it should check if the
> software interface is valid still and then allow the module to be
> loaded. Surely between version 2.6.8.1 and 2.6.9 nothing that drastic
> changed?

A *lot* of things changed.


> Or do I totally misunderstood versioning? 

Yes; basically versioning checks are a very rough approximation of a
check on ABI. Linux does not keep abi for modules at all, every single
release and a whopping lot of config options each result in an entirely
different ABI. Heck even most bugfixes will change the abi.


> Must a customer for instance
> request the module compiled for a specific kernel?

yes; however you're much better off shipping the sourcecode of your
module, or if your lawyer allows that (there may be some patent issues
involved), you can choose to ship a .o file and a glue layer, where the
glue layer abstracts the kernel ABI/API away entirely.



