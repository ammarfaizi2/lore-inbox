Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbVIZIIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbVIZIIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVIZIIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:08:49 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:14267 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751606AbVIZIIs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:08:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C4NQZNT6Xaop0s1a4PXur3s8DgoOZt5oDZeIsh5tJBBu3Q9YxK/yaPi0Sc8yx6cy/8gUah9YOdDR89avMCQ7ek0WzaFkkO4VrBRgpvSbWA3kiiVaik4+mybIeeSmnPTXeXyzj+eem2G+xuxV1qHHBauDNTLYihO4Pj7KfTFIA00=
Message-ID: <cda58cb805092601082ccda43b@mail.gmail.com>
Date: Mon, 26 Sep 2005 10:08:47 +0200
From: Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: How to add a new ram region ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050923155914.0e13e0e5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb805092300496abc8350@mail.gmail.com>
	 <20050923155914.0e13e0e5.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

2005/9/24, Randy.Dunlap <rdunlap@xenotime.net>:
> On Fri, 23 Sep 2005 09:49:43 +0200 Franck wrote:
>
> > Hi,
> >
> > I'm working on port of linux 2.6.13. The target is a custom board
> > based on a MIPS cpu. There are several RAMs on this board whose
> > address are not contiguous and don't start to 0 . I currently succeed
> > to make linux detect one of these RAM (the biggest one) but I'd like
> > to make linux able to use the others...I'd like to use the other in a
> > particular way: I would like to be able to allocate memory only on a
> > single RAM when needed in kernel space, and in userspace I would be
> > able to export a RAM disk that uses memory on a single RAM.
> >
> > Could someone tell me how to do that or give me some pointers  ?
>
> You can try the "memmap=" kernel boot options, although I don't
> know if or how well they apply to MIPS.  Some of them apparently
> do apply, according to Documentation/kernel-parameters.txt .
>

I looked at this kernel boot option and it seems that every given RAM
regions cannot be used separetly: once they're registered, I can't
allocate a page for a given region. Is that correct ?

Thanks
--
               Franck
