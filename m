Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbUKVUKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUKVUKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKVUHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:07:09 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:44965 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262571AbUKVTz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:55:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XRqKMlqS5js7oZV3WnduzJYQ/TPAt633VzecMDAhFfMfLHQ7OLNd5/O6htaB2C7gn01Uzmz9M7Z/MTO8hrlUrridVIZk6llvQaGedyyuYyCoOXM1DQe0jem9wS2ztXhr70NL5wFaoAvyl9c3RR8+el2lhu8HFnpF+sJTZ+I+IsY=
Message-ID: <29495f1d04112211554e78da67@mail.gmail.com>
Date: Mon, 22 Nov 2004 11:55:23 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: cranium2003 <cranium2003@yahoo.com>
Subject: Re: how netfilter handles fragmented packets
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
In-Reply-To: <20041121194202.14581.qmail@web41407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <29495f1d04112109372bb8ebe4@mail.gmail.com>
	 <20041121194202.14581.qmail@web41407.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2004 11:42:02 -0800 (PST), cranium2003
<cranium2003@yahoo.com> wrote:
> 
> --- Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> Hello Nish,
> 
> 
> 
> > On Sun, 21 Nov 2004 17:15:12 +0100 (MET), Jan
> > Engelhardt
> > <jengelh@linux01.gwdg.de> wrote:
> > > >hello,
> > > >          In ip_output.c file ip_fragmet function
> > when
> > > >create a new fragmented packet given to
> > output(skb)
> > > >function. i want to know which function are
> > actually
> > > >called by output(skb)?
> > >
> > > use stack_dump() (or was it dump_stack()?)
> >
> > dump_stack(), if you want to dump the current
> > process' stack context.
> >
> > -Nish
> >
> 
> can you please tell me how can i use dump_stack()
> method? so using dump_stack i will come to know which
> function will be called by output(skb) right? But
> where i get dump_stack()???

Last time i used it, I didn't need to do a darn thing. I believe it's
part of the traps code, so you can just call dump_stack().
dump_stack() will throw out the trace of the current task's stack at
the point when it is called. See what happens when you place it in
different places. Another option, if you ever have a hanging sytem is
Alt-SysRq-T (presuming you have the magic option enabled and you are
able to scrollback still), which pretty much calls dump_stack() for
all available processes.

-Nish
