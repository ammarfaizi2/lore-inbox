Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVCPFE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVCPFE3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVCPFE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:04:29 -0500
Received: from 209-204-138-32.dsl.static.sonic.net ([209.204.138.32]:1030 "EHLO
	graphe.net") by vger.kernel.org with ESMTP id S262518AbVCPFE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:04:26 -0500
Date: Tue, 15 Mar 2005 21:04:24 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
In-Reply-To: <20050315202331.008ec856.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503152103580.6087@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
 <20050315202331.008ec856.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005, Andrew Morton wrote:

> Christoph Lameter <christoph@lameter.com> wrote:
> >
> >  +#ifndef ____cacheline_pad_in_smp
> >  +#if defined(CONFIG_SMP)
> >  +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
> >  +#else
> >  +#define ____cacheline_pad_in_smp
> >  +#endif
> >  +#endif
>
> That's going to spit a warning with older gcc's.  "warning: unnamed
> struct/union that defines no instances".
>
Is it really that important? If the struct is named then there may be
conflicts if its used repeatedly.

