Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVAGMOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVAGMOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 07:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVAGMOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 07:14:16 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:670 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261384AbVAGMOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 07:14:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=V97Vc+DkyVdP1t2B6cPVxthoe8NyWLDfM/qpeI/IZyNV1u5veqzhudjcezgPMl2ENhoEQGGyXMKiLTMBj6pZ2wpIZ2j5ESqTf6+pG+aZFXIqjIFfy98pd+L/xg7YD6huXUORZBAHACNyWB5WL2iXx9I+5ZImrrTkX3jZMLYfF1k=
Message-ID: <69304d11050107041468805ff1@mail.gmail.com>
Date: Fri, 7 Jan 2005 13:14:03 +0100
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
In-Reply-To: <20050107091542.GA5295@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106152621.395f935e.akpm@osdl.org>
	 <20050106234123.GA27869@infradead.org>
	 <20050106162928.650e9d71.akpm@osdl.org>
	 <20050107002624.GA29006@infradead.org>
	 <20050107090014.GA24946@elte.hu> <20050107091542.GA5295@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005 09:15:42 +0000, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jan 07, 2005 at 10:00:14AM +0100, Ingo Molnar wrote:
> > so my strong position is that even asking for any 'warning period' for
> > changes in VFS internals (including exports/unexports) would be
> > extremely rude. It would be rude not only towards the authors and
> > maintainers of mainline VFS code, but also towards other external
> > trees/drivers who do _not_ ask for any special status and accept the
> > deal: "follow internals, notice kernel people if they do bad stuff
> > (extremely rare in my case) and fix/redesign stuff if the external tree
> > is broken (much more common)".
> 
> <sarcasm>
> <osdl-salespitch>
> Unfortunately you don't have the financial and political powers IBM
> has, so your opinion doesn't matter as much.  Maybe you should become
> OSDL member to influence the direction of Linux development.
> </osdl-salespitch>
> </sarcasm>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

If a filesystem is binary-only, then it should get the same treatment
as other binary-only things like graphic drivers and
machine-virtualization drivers: either stay on a designated kernel
version or else fix your driver so it work with mainline.

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
