Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311747AbSCNTrQ>; Thu, 14 Mar 2002 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311750AbSCNTrH>; Thu, 14 Mar 2002 14:47:07 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20721 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311747AbSCNTq4>; Thu, 14 Mar 2002 14:46:56 -0500
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
From: Brian Beattie <alchemy@us.ibm.com>
To: Larry Kessler <kessler@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C8FF7C7.5CA133B0@us.ibm.com>
In-Reply-To: <3C8FF7C7.5CA133B0@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 14 Mar 2002 11:45:40 -0800
Message-Id: <1016135141.26466.22.camel@w-beattie1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-13 at 17:07, Larry Kessler wrote:
> > Bernd wrote...
> > Of course it is only useful if it is not another framework because this will
> > lead to kernel clutter. So do we want to replace netlink and printk?
> 
> I checked and there are nearly 41,000 calls to printk in the 2.5.6 
> kernel.  Getting every maintainer to change to event logging's write
> functions
> would be impossible.  Instead we want to provide enhanced logging
> features 
> for new and updated device drivers and other kernel code--more of a
> "slow 
> migration over time" approach.  We provided the feature that creates
> POSIX
> event records from printks so that System Admins, field service,
> developers
> testing and debugging their code (just to name a few) could still take
> advantage of the new tools provided with the user lib (too numerous to
> mention, 
> but see the spec on the website) for handling printk messages. 
> 

Watching this whole event logging thing for a while, I wonder if a
slightly different approach might not be better.  Instead of adding
extra kernel functionality, would it not be possible to define a text
format to messages and some SIMPLE macros, to allow printk's to generate
the desired information.  

I understand about POSIX standards, but POSIX standards are not the
infallible word of of the diety of computing and sometimes are
completely bogos.  While they do provide a thoughtful plan, they are not
IMHO some holy grail.  for silly standards, see the recent stuff about
names for K = 10^6 vs. K= 2^10.

So if one drops strict POSIX compliamce and goes for providing the
information, it maye be possible to provide some formating guidelines
and support to printk and some log analysis tools to provide 99%
solution.

One thing to remember, is that the really hard and important part of
logging is not the part that can be legislated, or automated, it is
making sure that the correct events are reported in a accurate manner,
and this is not a one time job.  This being the case, I would rather see
effort expended in rationalizing the current printk's and improving
their use, than adding some new infrastructure that may well be a
perfromance drain and might even be more prone to loss of log messages,
than the current method.

