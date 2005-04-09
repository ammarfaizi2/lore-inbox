Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVDIKDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVDIKDr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 06:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVDIKDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 06:03:47 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:16722 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261324AbVDIKDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 06:03:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=YOcWQ62taO6G4mzbVo3/0VvYgMI5d1iuwNslyLZ3Dihnic2RCFSrxK0rvc5vyHREiDH3ApbnjxwwKf9kL3rnrFrmofAFGlPhhriM/y5KMEhh/jckeBjU/tUa1xrt6H4ccFtKS3cV6HgUAU9MuZ+MGFqFQ4lHvjexmf/yFQPeRas=
Message-ID: <aec7e5c30504090303790ff7a7@mail.gmail.com>
Date: Sat, 9 Apr 2005 12:03:45 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH][RFC] disable built-in modules V2
Cc: rddunlap@osdl.org, linux-os@analogic.com, roland@topspin.com,
       asterixthegaul@gmail.com, damm@opensource.se,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050409094814.GA5953@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <aec7e5c305040711535bbe07d3@mail.gmail.com>
	 <E1DK4zA-0005rr-00@gondolin.me.apana.org.au>
	 <aec7e5c3050409024365d724dd@mail.gmail.com>
	 <20050409094814.GA5953@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 9, 2005 11:48 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Sat, Apr 09, 2005 at 11:43:59AM +0200, Magnus Damm wrote:
> >
> > > Perhaps your favourite distribution could build that as a module to
> > > start with.
> >
> > Right. Today distributions can boot from external usb-storage devices,
> > maybe even from firewire hardware as I am sure you know. I guess they
> > have support for a device built-in for a reason. I think most
> 
> Perhaps they should start using initramfs then.

But how does that help me? I still want to be able to pass a list of
unwanted modules on the kernel command line. Using initramfs and
modules is fine, although I would prefer being able to unload built-in
modules instead - but that is another story. Your suggestion just
pushes the problem to user space. I think the best alternative would
be a combination of kernel-space code (my patch) and awareness of the
command line in the module loader running from initramfs/rootfs.

/ magnus
