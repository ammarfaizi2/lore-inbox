Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDFQKp>; Fri, 6 Apr 2001 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRDFQKg>; Fri, 6 Apr 2001 12:10:36 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:11157 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S131832AbRDFQK1>;
	Fri, 6 Apr 2001 12:10:27 -0400
Date: Fri, 6 Apr 2001 09:09:37 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: Christopher Turcksin <turcksin@raleigh.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Miller, Brendan" <Brendan.Miller@Dialogic.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Proper way to release binary driver?
In-Reply-To: <3ACDE5C5.CEB65D4A@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.30.0104060904330.2055-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd take a look at how nvidia delivers the module for their video
cards...

http://www.nvidia.com/Products/Drivers.nsf/Linux.html

you build the module with your current kernel or download the one for your
distribution (limited number)

4-front tenchnologies has also done a long-term good job on this with oss

joelja

On Fri, 6 Apr 2001, Christopher Turcksin wrote:

> "Eric W. Biederman" wrote:
>
> > If what you are after is a way to release a driver that is not a
> > hassle to add to an already working system, you will find a more
> > receptive ear.  I have heard some talk, that it would be a good idea
> > to figure out how to standardize how to compile a kernel driver
> > outside the kernel tree, so it could be trivial enough that anyone
> > could do it.  To date there are enough people around who don't have
> > problems compiling their own kernel that this hasn't become a major
> > issue.
>
> Eric,
>
> I am finding myself exactly in this situation, and I've got a feeling
> that this won't be the last time either.
>
> I expect that every future Linux driver I get involved with will be
> released under GPL. However, I think that the majority of our customers
> will be running a distribution that does not yet support a new driver,
> and even at Linux speeds, it'll take a long enough time that customers
> cannot afford to wait for the next release that includes the driver.
>
> So the big issue for us appears to be how we support these customers.
>
> There is no way that we can support customers who have custom kernels,
> but since they are 'in it' enough to compile their own kernel, I guess
> they're able to apply our patch and recompile it. I actually suspect
> that there aren't that many who do this anyway.
>
> Where we find we have a problem is the number of different 'standard'
> kernels out there. We find that we need to support all releases since
> the last year or so for each distribution. And for each of those, we
> find that there are many different kernel versions (some bugfixes, some
> provide half a dozen different kernels with the CDs, aso.). And since we
> do not expect these customers to compile their own kernel, we see no
> option but to provide a precompiled binary driver. The numbers multiply
> quickly and building all of those becomes an interesting problem.
>
> We had hoped that MODVERSIONS would allow us to provide a single (or at
> most a few) binary driver. Kernels with even minor version numbers are
> supposed to be stable (even if they are buggy) ie. not have wildly
> changing kernel interfaces.
>
> In practice, that doesn't work. A driver compiled with 2.2.16 doesn't
> load with 2.2.16-5.0 (from RedHat 6.2) (just an example).
>
>
>
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


