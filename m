Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWESTCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWESTCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWESTCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:02:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:49809 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932464AbWESTCc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:02:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rKegBmf5mWBDqu8LeRPhZe7ySroR6EjsuDsuiowfQ+WWwog2x4m4FlzkbwKZ1z7SAWttcloUTGspv/GiYs7YVplXJYTnYxgsuw2wOHQVZAphvgBx/gHcD2HCL11CKlDhs5JdzDIAOHIwo2n+N/1V9FZHSbaDACqLBg78S/NIpik=
Message-ID: <661de9470605191202p5b46312bya129d59ea06041bf@mail.gmail.com>
Date: Sat, 20 May 2006 00:32:31 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [Patch 0/6] statistics infrastructure
Cc: "Martin Peschke" <mp3@de.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <661de9470605191159n75578d60qd1f3309e3a7e2234@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060519092411.6b859b51.akpm@osdl.org>
	 <661de9470605191159n75578d60qd1f3309e3a7e2234@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/06, Balbir Singh <balbir@in.ibm.com> wrote:
>
> On 5/19/06, Andrew Morton <akpm@osdl.org> wrote:
>
> >  Martin Peschke <mp3@de.ibm.com> wrote:
> > >
> > > My patch series is a proposal for a generic implementation of statistics.
> >
> > This uses debugfs for the user interface, but the
> > per-task-delay-accounting-*.patch series from Balbir creates an extensible
> > netlink-based system for passing instrumentation results back to userspace.
> >
> > Can this code be converted to use those netlink interfaces, or is Balbir's
> > approach unsuitable, or hasn't it even been considered, or what?
> >
> >
>
Hi, Martin/Andrew,

I am resending this email, my mailer got crazy and sent out HTML (sorry!)

I have seen the patches around, but I've had no time to review them. I
was planning to do so this weekend.

The main difference I see, like you pointed out is the netlink
interface vs debugfs. I think the netlink approach is more suitable
(there is no need to mount a filesystem and create files followed by
frequent open/read/close operations). Just one netlink socket should
do the trick. The event subscription mechanism in netlink is very
useful as well.

Martin, could you please take a look at the taskstats interface and
see if it is possible to make use of them?

Thanks,
Balbir
