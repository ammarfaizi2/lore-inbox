Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWCPFXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWCPFXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWCPFXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:23:04 -0500
Received: from xenotime.net ([66.160.160.81]:35530 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932657AbWCPFXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:23:03 -0500
Date: Wed, 15 Mar 2006 21:24:59 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: Fix gus_pcm dereference before NULL
Message-Id: <20060315212459.74cc8b78.rdunlap@xenotime.net>
In-Reply-To: <20060316020007.GA20734@eugeneteo.net>
References: <20060316020007.GA20734@eugeneteo.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.2 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2006 10:00:07 +0800 Eugene Teo wrote:

> substream is dereferenced before checking for NULL.
> 
> Coverity bug #861
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> 
> --- linux-2.6/sound/isa/gus/gus_pcm.c~	2006-03-15 10:05:45.000000000 +0800
> +++ linux-2.6/sound/isa/gus/gus_pcm.c	2006-03-16 09:51:43.000000000 +0800
> @@ -103,8 +103,8 @@

BTW, please use "-p" diff option so that the "@@" sections
include function or struct names etc.  I.e., be nice to patch
readers/reviewers.  :)

---
~Randy
