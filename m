Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264877AbUFASOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbUFASOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFASOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 14:14:51 -0400
Received: from smtp-out1.xs4all.nl ([194.109.24.11]:35857 "EHLO
	smtp-out1.xs4all.nl") by vger.kernel.org with ESMTP id S264877AbUFASOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 14:14:50 -0400
Date: Tue, 1 Jun 2004 20:14:46 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: RH's noninteractive config patch
In-Reply-To: <20040531092044.GA14091@lst.de>
Message-ID: <Pine.LNX.4.58.0406011950500.13079@scrub.local>
References: <20040531092044.GA14091@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 May 2004, Christoph Hellwig wrote:

> Arjan said you some objections against RH's current noninteractive
> config patch?  I'd really love to see something like it included
> because it greatly helps packagaing the kernel.  Patch from their
> current RPM is below:

conf.c is already heavy overloaded and I'd rather add a separate querytool 
(which could also answer such burning questions as "what keeps that damn 
config symbol selected?"). IIRC the RH build first checks, whether the 
.config is valid, which can basically be done with "make silentoldconfig 
>& /dev/null" and printing the config symbols can be done with a separate 
tool. The Kconfig back end is a library to make this as simple as 
possible.

bye, Roman
