Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272207AbUKARhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272207AbUKARhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271896AbUKARhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:37:14 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:20195 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265766AbUKARgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:36:23 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] document mmiowb and readX_relaxed a bit more in deviceiobook.tmpl
Date: Mon, 1 Nov 2004 09:36:10 -0800
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200410291747.24035.jbarnes@engr.sgi.com> <1099103756.29689.194.camel@gaston>
In-Reply-To: <1099103756.29689.194.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411010936.10127.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 29, 2004 7:35 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2004-10-29 at 17:47 -0700, Jesse Barnes wrote:
> > This is a small patch to deviceiobook.tmpl to describe the new mmiowb
> > routine a bit more completely.  I've also updated it to provide pointers
> > to drivers that do write flushing, use mmiowb, and use the readX_relaxed
> > routines.
>
> It's all good, but your semantics and description are very tailored to
> your specific arch problem vs. unlock.
>
> What about my suggestion of defining a broader semantic of mmiowb() as
> beeing a barrier ordering MMIOs vs. the rest of the world ? The later
> includes stores to memory _and_ spinlock/unlock.

Yeah, that's ok with me, just be sure to update the documentation when you add 
the PPC stuff.  Seems like a worthwhile optimization.

thanks,
Jesse
