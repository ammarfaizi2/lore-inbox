Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbVIOPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbVIOPG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030489AbVIOPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:06:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:11904 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030488AbVIOPGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:06:55 -0400
Date: Thu, 15 Sep 2005 17:06:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Separate tainted code from panic code
In-Reply-To: <20050915082049.GA29266@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0509151703450.3743@scrub.home>
References: <20050913230718.GA14867@mipter.zuzino.mipt.ru>
 <20050913172816.35835b66.akpm@osdl.org> <20050915082049.GA29266@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Sep 2005, Alexey Dobriyan wrote:

> > Why?  What reason is there for making these changes?
> 
> Most tainted users are in arch/$ARCH/kernel/. The rest including
> kernel.h don't want tainted stuff. And kernel.h is used often.

The tainted definitions don't change very often, they also have no config 
dependencies, so the benefit of separating this is very low.

bye, Roman
