Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422858AbWCXOUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422858AbWCXOUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422859AbWCXOUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:20:16 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:5530 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422858AbWCXOUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:20:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=do2dUNa+H8vyIAyVtmzlWGGL+2auhxSnOmMCwzE+ePMF5xL4YiePTE5v29ljA/K5sGmB5oIfsEKqOzUJQZQPDfx4AtLq864SYRBKRburmwho9h3FWyew3+cQipfyFz3g65B4lzil5aA++agW8SG/vlA1/+dgTmdtYYsz8MYopMI=
Message-ID: <4c4443230603240620s5baab07ei361b54625dcefd7e@mail.gmail.com>
Date: Fri, 24 Mar 2006 22:20:12 +0800
From: yang.y.yi@gmail.com
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Connector: Filesystem Events Connector v3
Cc: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>, "Andrew Morton" <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       matthltc@us.ibm.com
In-Reply-To: <1143188094.2882.22.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4423673C.7000008@gmail.com>
	 <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
	 <20060323232345.1ca16f3f.akpm@osdl.org>
	 <20060324080839.GB5426@2ka.mipt.ru>
	 <1143188094.2882.22.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2006-03-24 at 11:08 +0300, Evgeniy Polyakov wrote:
> > On Thu, Mar 23, 2006 at 11:23:45PM -0800, Andrew Morton (akpm@osdl.org)
> wrote:
> > > "David S. Miller" <davem@davemloft.net> wrote:
> > > >
> > > > From: Arjan van de Ven <arjan@infradead.org>
> > > >  Date: Fri, 24 Mar 2006 07:59:01 +0100
> > > >
> > > >  > then make the syslog part optional.. if it's not already!
> > > >
> > > >  Regardless I still think the filesystem events connector is a useful
> > > >  facility.
> > >
> > > Why's that?
> > >
> > > (I'd viewed it as a fun thing, but I haven't really seen much pull for
> it,
> > > and the scalability issues in there aren't trivial).
> >
> > This module uses ratelimiting of event generation, so it will not hurt
> > performance, but probably this should be somehow tuned from userspace.
>
>
> .. so it has become unreliable for any kind of real use that depends on
> getting complete events. Such as virus scanning or updatedb etc
>
>
If there is such a use, that explains this connector is useful a bit,
ratelimiting is used to prevent DoS, audit also has such a feature,
you may take a look at it.
