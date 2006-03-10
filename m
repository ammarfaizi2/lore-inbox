Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752251AbWCJXyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbWCJXyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWCJXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 18:54:18 -0500
Received: from smtp-out.google.com ([216.239.45.12]:60372 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752245AbWCJXyR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 18:54:17 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=rFf3CBxWNQHBP2QAOI7BBnXiC63yvTjM0tWGxog+hgPHzzDl01pf1NSs+SGtRF5cM
	Xba8zQkyjcDi0bXtGJZVA==
Message-ID: <545d88bc0603101553i3cd98368y8e9f9b2f79d294ce@mail.google.com>
Date: Fri, 10 Mar 2006 15:53:56 -0800
From: dkegel <dkegel@google.com>
To: dkegel <dkegel@google.com>, "Andrew Morton" <akpm@osdl.org>,
       "Markus Gutschke" <markus@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on i386
In-Reply-To: <20060310234010.GA6549@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4410BB32.1020905@google.com>
	 <20060309184759.591e3551.akpm@osdl.org> <4410EC8A.4020808@google.com>
	 <20060309192232.2fd4767c.akpm@osdl.org>
	 <545d88bc0603091936i5c25c065ne8e31ca23e9473f4@mail.google.com>
	 <20060310234010.GA6549@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/06, Daniel Jacobowitz <dan@debian.org> wrote:
> > I'd like to see these patches go in to the sanitized kernel headers
> > and/or the kernel.org tree.  I imagine that putting them in the kernel.org
> > tree is right, and they'd naturally percolate from there to the
> > various sanitized headers projects.
>
> It uses the headers for many things.  It does not use the _syscallX
> macros.

Sorry, I misspoke.
The glibc build process makes the _syscallX macros available
to userspace via the <asm/syscalls.h> include.
So even if glibc doesn't use those macros directly,
it does seem to pass them along.  Which is how
Markus got on to this whole topic in the first place.
