Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVB1J47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVB1J47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 04:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVB1J47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 04:56:59 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:23770 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261431AbVB1J4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 04:56:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CJU2tQmhIi38lXwaIL3HGDM+EbJQLBKzXAP76cEprJC1b6hwXiziQoYYLfuw0o1/I1GMFrlxIPaW1AtmyVUqiofJ6ePrwQaujGrQVgLIPN8XZR5IfvneGNNp925Wy+5nN5K/+bbWlBCAFxSzgwzmvueJqADQcqExc4My0ThGdAI=
Message-ID: <3f250c7105022801564a0d0e13@mail.gmail.com>
Date: Mon, 28 Feb 2005 05:56:54 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: hugh@veritas.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       rrebel@whenu.com, marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
In-Reply-To: <3f250c71050228014355797bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
	 <3f250c710502220513179b606a@mail.gmail.com>
	 <3f250c71050224003110e74704@mail.gmail.com>
	 <20050224010947.774628f3.akpm@osdl.org>
	 <3f250c710502240343563c5cb0@mail.gmail.com>
	 <20050224035255.6b5b5412.akpm@osdl.org>
	 <3f250c7105022507146b4794f1@mail.gmail.com>
	 <3f250c71050228014355797bd8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just some explanation about the mistake.

I have put cat /proc/pid/status instead of /proc/pid/smaps.

So I was testing the /proc/pid/status and not the /proc/pid/smaps.

Now I am testing with /proc/pid/smaps and the values are showing that
the old one is faster than the new one. So I will keep using the old
smaps version.

Any suggestion???

BR,

Mauricio Lin.

On Mon, 28 Feb 2005 05:43:05 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> Hi all,
> 
> I comitted a mistake. Indeed the old smaps is still faster than new one.
> 
> Take a look:
> 
> Old smaps
> real 19.52
> user 2.15
> sys 17.27
> 
> New smaps
> real 25.93
> user 3.19
> sys 22.31
> 
> Any comments????
> 
> BR,
> 
> Mauricio Lin.
> 
> On Fri, 25 Feb 2005 11:14:36 -0400, Mauricio Lin <mauriciolin@gmail.com> wrote:
> > Hi all,
> >
> > I tested the two smaps entry using time command.
> >
> > I tested 100.000 cat commands with smaps for each version.
> >
> > I checked the difference between the two versions and the new one is
> > faster than old one. So Hugh is correct about the loop performance.
> >
> > Thanks!!!
> >
> > Mauricio Lin.
> >
> > On Thu, 24 Feb 2005 03:52:55 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > > Mauricio Lin <mauriciolin@gmail.com> wrote:
> > > >
> > > > But can i use jiffies to measure this kind of performance??? AFAIK, if
> > > >  it is more efficient, then it is faster, right? How can I know how
> > > >  fast it is? Any idea?
> > >
> > > umm,
> > >
> > > time ( for i in $(seq 100); do; cat /proc/nnn/smaps; done > /dev/null )
> > >
> > > ?
> > >
> >
>
