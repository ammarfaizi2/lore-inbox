Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933165AbWFXBDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbWFXBDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 21:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933171AbWFXBDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 21:03:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:22448 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S933165AbWFXBDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 21:03:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUh0zp/EIPw5AsYPgtT557Wjtq+YQOIBA6R/oMX63kMOl4Jm31zXXcc6gRxmK7FbW3ZTPy7YIHkAbg0O9tpK8K/D3B3Y6CEGKtZtqNgd7dLC861FeE8/P93+YLp1h2GzMaTKIhGCIAXcA+piNxhc0FQqQ0ic4pQd2eixjDZJeMQ=
Message-ID: <a762e240606231803p72e4e684v42cf27cdaf8fb30f@mail.gmail.com>
Date: Fri, 23 Jun 2006 18:03:35 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] [20/82] i386: Panic the system when a NUMA kernel doesn't run on IBM NUMA
Cc: "Dave Jones" <davej@redhat.com>, torvalds@osdl.org, discuss@x86-64.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200606240242.31906.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <449C8510.mailCWD11E44E@suse.de>
	 <20060624003856.GE19461@redhat.com> <200606240242.31906.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/06, Andi Kleen <ak@suse.de> wrote:
> On Saturday 24 June 2006 02:38, Dave Jones wrote:
> > On Sat, Jun 24, 2006 at 02:19:28AM +0200, Andi Kleen wrote:
> >
> >
> >  > +  extern int use_cyclone;
> >  > +  if (use_cyclone == 0) {
> >  > +          /* Make sure user sees something */
> >  > +          static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
> >  > +          early_printk(s);
> >  > +          panic(s);
> >  > +  }
> >
> > non-IBM Machines do still boot with that enabled though don't they?
>
>
> No they don't - as they likely didn't do before. e.g. Opterons generally
> break and that brings the point across clearer.
>
> The rationale is that CONFIG_NUMA is very rarely used on i386 (even on summit)
> and always does bitrot quickly. It also doesn't work at all on a wide
> range of machines.

I agree that i386 CONFIG_NUMA is only ment to boot on small subset of
hw but there is litte motivation to boot a numa kernel on a non-numa
box.  I am supprised that no one has enabled i386 AMD NUMA (the one
numa box that regular people have access to).

> I'm sure someone will bring up now an example where their non Summit
> machine booted with CONFIG_NUMA, but they were just extremly lucky
> and unlikely to be for very long.

Current Summit HW  (x460) dosen't use/have a cyclone.  There are
patches submitted to this list to support it's i386 NUMA boot.

Thanks,
  Keith
