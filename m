Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUJWDkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUJWDkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269324AbUJWDjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:39:53 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:12388 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267985AbUJWDgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:36:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kAMohmypqZhOUwXmwi95ryK5xAKjB25e/2mm3Oe5KUIwFK2nHORQJFSVCHtb89UaMZ+C/bZVW7vKq2rS8fUK4VGwQqdaAWnk4XuQ9qcCqxym+yHZHv6J4i5wINkDj3OecVV5/P4cXqT84INQnbBxKwtCZks0z4KaVSnGBXkY4RI=
Message-ID: <9e47339104102220361bf42988@mail.gmail.com>
Date: Fri, 22 Oct 2004 23:36:20 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Resolving missing external symbols at module load time.
In-Reply-To: <9e47339104102213472193a6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104102213472193a6df@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 16:47:44 -0400, Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm looking at how to get rid of the inter_module_get calls in DRM to
> AGP. What is the proper procedure to reference an external symbol that
> may be any of the following:
> 
> 1) compiled in
> 2) module that is loaded
> 3) non-existent since the system doesn't have the hardware
> 
> With inter_module_get() #1 and #2 would succeed and return a pointer
> to the module. #3 would fail. The DRM code then handled each of these
> cases. I've been looking at the new module calls and and I can't see
> how to make this work.
> 
> The symbol resolution also needs to work if DRM is compiled in and the
> system has no AGP support.

I've found some old posts in the lkml archives and now I see this is
what symbol_get()/symbol_put() are for.

-- 
Jon Smirl
jonsmirl@gmail.com
