Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVAFL15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVAFL15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 06:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVAFL15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 06:27:57 -0500
Received: from open.hands.com ([195.224.53.39]:17304 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S262580AbVAFL1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 06:27:54 -0500
Date: Thu, 6 Jan 2005 11:38:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Rik van Riel <riel@redhat.com>
Cc: Mark Williamson <maw48@cl.cam.ac.uk>, xen-devel@lists.sourceforge.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Message-ID: <20050106113827.GM6440@lkcl.net>
References: <20050102162652.GA12268@lkcl.net> <20050103205318.GD6631@lkcl.net> <1104785749.13302.26.camel@localhost.localdomain> <200501040304.10128.maw48@cl.cam.ac.uk> <Pine.LNX.4.61.0501040902400.25392@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501040902400.25392@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:05:13AM -0500, Rik van Riel wrote:
> On Tue, 4 Jan 2005, Mark Williamson wrote:
> 
> >>for doing opportunistic page recycling ("I dont need this page but when
> >>I ask for it back please tell me if you trashed the content")
> >
> >We've talked about doing this but AFAIK nobody has gotten round to it 
> >yet because there hasn't been a pressing need (IIRC, it was on the todo 
> >list when Xen 1.0 came out).
> >
> >IMHO, it doesn't look terribly difficult but would require (hopefully 
> >small) modifications to the architecture independent code, plus a little 
> >bit of support code in Xen.
> 
> The architecture independant changes are fine, since
> they're also useful for S390(x), PPC64 and UML...
> 
> >I'd quite like to look at this one fine day but I suspect there are more 
> >useful things I should do first...
> 
> I wonder if the same effect could be achieved by just
> measuring the VM pressure inside the guests and
> ballooning the guests as required, letting them grow
> and shrink with their workloads.
 
 mem = 64M-128M
 target = 64M

 "if needed, grow me to 128mb but if not, whittle down to 64".

 mem=64M-128
 target=128M

 "if you absolutely have to, steal some of my memory, but don't nick
 any more than 64M".

 i'm probably going to have to "manually" implement something like this.

 l.

