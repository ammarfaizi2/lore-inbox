Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946408AbWJ0L0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946408AbWJ0L0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946410AbWJ0L0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:26:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48523 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1946408AbWJ0L0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:26:03 -0400
Date: Fri, 27 Oct 2006 13:25:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: so what's so special about sema_init() for alpha?
In-Reply-To: <Pine.LNX.4.64.0610242150460.28319@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610271323020.6762@scrub.home>
References: <Pine.LNX.4.64.0610242150460.28319@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 24 Oct 2006, Robert P. J. Day wrote:

>   i'm still curious as to why the implementation for sema_init() for
> the alpha can't be simplified as (allegedly) could all of the other
> architecture sema_init() calls.

Did you even look at the code it generates? It's not specific to alpha 
at all. Unless the structure is small enough, gcc will first generate a 
copy on the stack and then copy it to its final location.

bye, Roman
