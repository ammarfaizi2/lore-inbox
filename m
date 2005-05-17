Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVEQBY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVEQBY2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEQBY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:24:28 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:41671 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261296AbVEQBYY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:24:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FZ0BmwE4pycV5ST31xezuV2EdMEMAVxnEpwtnW2mgUjTUEKpjC4TlYBHFI7Mk8ytMK1CfLGOm0ZWYO2o+vPVwHUQIG0yXKn2PYw6/Hdj9fHZ2VyuuLQ1MD6yaQoq/hvDH2MNtJinOqMKw6E3rSOm3xAFJC2D0InVyc8NAQm6gHw=
Message-ID: <2cd57c9005051618243be2ae14@mail.gmail.com>
Date: Tue, 17 May 2005 09:24:23 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Matt Mackall <mpm@selenic.com>
Subject: Re: serial console
Cc: Andrew Morton <akpm@osdl.org>, YhLu@tyan.com, linux-tiny@selenic.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050516234757.GG5914@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB>
	 <20050516205731.GA5914@waste.org> <20050516231508.GD5914@waste.org>
	 <20050516163712.66a1a058.akpm@osdl.org>
	 <20050516234757.GG5914@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Matt Mackall <mpm@selenic.com> wrote:
> On Mon, May 16, 2005 at 04:37:12PM -0700, Andrew Morton wrote:
> >
> > It would be nicer if this was a static inline, so all the function call
> > code at the callsites is removed by the compiler.
> 
> Better yet, a patch that's actually right. add_preferred_console is
> setting the console used by init and so on, so it's still relevant
> with CONFIG_PRINTK off. So I just move it out of the ifdef. Obviously
> more correct(tm).
> 
> Move add_preferred_console out of CONFIG_PRINTK so serial console does
> the right thing.


What's the purpose of serial console if printk is disabled?  I suggest
we put add_preferred_console and all its callers, console code etc
into CONFIG_PRINTK.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
