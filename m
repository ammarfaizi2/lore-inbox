Return-Path: <linux-kernel-owner+w=401wt.eu-S965412AbWLPS52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965412AbWLPS52 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965416AbWLPS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:57:28 -0500
Received: from codepoet.org ([166.70.99.138]:50232 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965412AbWLPS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:57:27 -0500
Date: Sat, 16 Dec 2006 11:57:26 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       viro@zeniv.linux.org.uk, Alexey Dobriyan <adobriyan@gmail.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [patch] scrub non-__GLIBC__ checks in linux/socket.h and linux/stat.h
Message-ID: <20061216185726.GA17496@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, viro@zeniv.linux.org.uk,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>
References: <8bd0f97a0612161042g3b61d42csd54cae46e4864f30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd0f97a0612161042g3b61d42csd54cae46e4864f30@mail.gmail.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Dec 16, 2006 at 01:42:11PM -0500, Mike Frysinger wrote:
> On 11/30/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> >but there are a few other
> >cases which still contain compound preprocessor directives such as:
> >
> >  #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
> >
> >having never worked with unifdef before, i guess i was being overly
> >optimistic in thinking that it, if i "unifdef"ed __KERNEL__, it might
> >at least simplify the expression.  oh, well ... live and learn.
> 
> userspace should be worrying about userspace, so having the socket.h
> and stat.h pollute the namespace in the non-glibc case is wrong and
> pretty much prevents any other libc from utilizing these headers
> sanely unless they set up the __GLIBC__ define themselves (which
> sucks)
> -mike

Ack from me.  I'd love to see this applied so uClibc could
stop have to define __GLIBC__

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
