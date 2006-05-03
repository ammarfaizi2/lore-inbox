Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWECHk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWECHk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWECHk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 03:40:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:10933 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964922AbWECHk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 03:40:29 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: 2.6.17-rc2-mm1
Date: Wed, 3 May 2006 09:38:37 +0200
User-Agent: KMail/1.9.1
Cc: "Martin Bligh" <mbligh@google.com>, "Andrew Morton" <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
References: <4450F5AD.9030200@google.com> <200605030849.44893.ak@suse.de> <4458730F.76E4.0078.0@novell.com>
In-Reply-To: <4458730F.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030938.37967.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 09:08, Jan Beulich wrote:
> >> ><EOE>new stack 0 (0 0 0 10082 10)
> >> 
> >> Looks like <rubbish> <SS> <RSP> <RFLAGS> <CS> to me, ...
> >
> >Hmm, right.
> > 
> >> >Hmm weird. There isn't anything resembling an exception frame at the top of the
> >> >stack.  No idea how this could happen.
> >> 
> >> ... which is a valid frame where the stack pointer was corrupted before the exception occurred. One more printed
> item
> >> (or rather, starting items at estack_end[-1]) would allow at least seeing what RIP this came from.
> >
> >Any can you add that please and check? 
> ???

Sorry I meant to write Andy but left out the d :-( - he did the testing
on the machine that showed the problem.

> 

> 
> >Also worst case one could dump last branch pointers. AMD unfortunately only has four,
> >on Intel with 16 it's easier.
> 
> Provided you disable recording early enough. Otherwise only one (last exception from/to) is going to be useful on
> both.

i usually just saved them as first thing in the exception entry point.

> >That can cause recursive exceptions. I'm a bit paranoid with that.
> 
> Without doing so it can also cause recursive exceptions, just that this is going to be deadly then.

Hmm point.

-Andi

 
