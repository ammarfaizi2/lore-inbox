Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVCPEX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVCPEX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVCPEXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:23:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:59070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262508AbVCPEXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:23:51 -0500
Date: Tue, 15 Mar 2005 20:23:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
Message-Id: <20050315202331.008ec856.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
>  +#ifndef ____cacheline_pad_in_smp
>  +#if defined(CONFIG_SMP)
>  +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
>  +#else
>  +#define ____cacheline_pad_in_smp
>  +#endif
>  +#endif

That's going to spit a warning with older gcc's.  "warning: unnamed
struct/union that defines no instances".
