Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVIWPXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVIWPXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVIWPXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:23:07 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:15604 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751082AbVIWPXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:23:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FQerJCyJe9DvDpdRALJqgUPEmKKcsFnWOzxHTIoNoB41osaaYad2+3KZo3AVqDHJXktXUvWR/Yv9F9IRqP+4O8iNmdgmCyq6l6ljIJ4/mcXf5kYL53TrGMFX4jQrVIscajZ1bUn7J39NahlQwCplTJKVQJv+RtZ/scvts9ZxvOs=
Date: Fri, 23 Sep 2005 19:33:45 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm v2] Bisecting through -mm with quilt
Message-ID: <20050923153345.GC28868@mipter.zuzino.mipt.ru>
References: <20050923003217.GA18675@mipter.zuzino.mipt.ru> <20050922174250.71f9c6a9.akpm@osdl.org> <20050923152025.GA28868@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923152025.GA28868@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 07:20:25PM +0400, Alexey Dobriyan wrote:
> On Thu, Sep 22, 2005 at 05:42:50PM -0700, Andrew Morton wrote:
> > hm, I wouldn't use it.  The problem is that a _lot_ of patches in -mm don't
> > fscking compile.
> > 
> > 	bix:/usr/src/25> grep '[-]fix.patch' series | wc
> > 	     72      72    2905
> > 
> > If your bisection happens to land you between foo.patch and foo-fix.patch,
> > you have a *known bad* kernel.   What's the point in testing it?

If "./bisect-mm apply" landed you to obviously wrong kernel, with v2 you
can do a couple of "quilt {push,pop}" by hand. "./bisect {bad,good}"
marks _current_ patch as reported by "quilt top".

