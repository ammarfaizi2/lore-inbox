Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312103AbSCQTg4>; Sun, 17 Mar 2002 14:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312102AbSCQTgq>; Sun, 17 Mar 2002 14:36:46 -0500
Received: from bdsl.66.13.29.10.gte.net ([66.13.29.10]:23936 "EHLO
	Bluesong.NET") by vger.kernel.org with ESMTP id <S311314AbSCQTgl>;
	Sun, 17 Mar 2002 14:36:41 -0500
Message-Id: <200203171943.g2HJhDt25321@Bluesong.NET>
Content-Type: text/plain; charset=US-ASCII
From: "Jack F. Vogel" <jfv@trane.bluesong.net>
Reply-To: jfv@bluesong.net
To: Greg KH <greg@kroah.com>, Gordon J Lee <gordonl@world.std.com>
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Date: Sun, 17 Mar 2002 11:43:13 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <3C92A4EB.C50ED834@world.std.com> <20020316055833.GB8125@kroah.com>
In-Reply-To: <20020316055833.GB8125@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 09:58 pm, Greg KH wrote:
> On Fri, Mar 15, 2002 at 08:50:35PM -0500, Gordon J Lee wrote:
> > > Eeek, these machines are now in the wild?  Didn't realize this :)
> >
> > Yes.  They are still ramping up production, and evals are scarce.
> > I am pretty excited about it, because on paper, even without
> > the hyperthreading, they should run pretty fast for I/O intensive
> > workloads.  My current eval project is to get some empirical
> > performance numbers on a particular application.
>
> Great, it will be nice to see some real world use of these machines to
> see how well the HyperThreading works out.
>
> > As a matter of fact, we did try a UP 2.2.x kernel, and it worked.  But
> > then we only have one CPU, and where is the fun in that ?  :-)
> > So I suppose this gives further support to the mishandled APIC table
> > theory.
>
> Yes it does, thanks for testing this.
>
> > I am interested and motivated to understand the details of APIC's
> > further. If I were to attempt to patch up a 2.2.x kernel to workaround
> > this problem,
> >
> > what documentation should I have on hand ?  I have an Intel SMP 1.4
> > doc, although I haven't studied it in detail yet.  Is this sufficient or
> > are there other Must Have documents that I will need ?
>
> James would be the best person for this, as he got this machine up and
> working on Linux properly.

The x360 doesnt require James' current patches (that arent in the mainstream
quite yet), but what it DOES require that you wont have in the 2.2 stream 
is ACPI parsing. 

The Linus kernel has support to boot fully HT on these boxes as of 2.4.17.
There are a number of changes related to the processor in it. In order to
detect HT you will need the acpitable code. In order to have the machine
function well beyond that you will want changes that Ingo put into the
scheduler :).

Personally I cant tell how much work you will have porting drivers to 2.4
but it might be easier than getting all the support you need back into
the 2.2 kernel, and even if you do backport it I dont know that you'd 
get it in officially :)

Cheers,


-- 
Jack F. Vogel
IBM  Linux Solutions
jfv@us.ibm.com  (work)
jfv@Bluesong.NET (home)
