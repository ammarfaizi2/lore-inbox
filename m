Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWEYVi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWEYVi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 17:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWEYVi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 17:38:27 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:30481 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030436AbWEYVi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 17:38:26 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: [PATCH] Add compile domain
Date: Thu, 25 May 2006 22:38:37 +0100
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
References: <20060525141714.GA31604@skunkworks.cabal.ca> <Pine.LNX.4.61.0605252100070.13379@yvahk01.tjqt.qr> <44761E38.7050702@mbligh.org>
In-Reply-To: <44761E38.7050702@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605252238.37352.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 May 2006 22:14, Martin J. Bligh wrote:
> > 20:35 mason:/etc # rpm -qf `which hostname`
> > net-tools-1.60-37
> > 21:00 mason:/etc # hostname -v
> > gethostname()=`mason'
> > mason
> > 21:00 mason:/etc # hostname --fqdn
> > mason
> > 21:00 mason:/etc # domainname
> > (none)
> > 21:00 mason:/etc # dnsdomainname
> >
> >
> > Runs Aurora Linux 2.0.
>
> Ubuntu does this too:
>
> mbligh@flay:~$ hostname
> flay
> mbligh@flay:~$ hostname --fqdn
> localhost.localdomain

I think it's as Lennart suggested. From the man page for /etc/hosts ("man 
hosts"), it seems to suggest that the format should be:

IP_address canonical_hostname aliases

On Ubuntu and approximately on my system, it's doing:

127.0.0.1 localhost.localdomain <alias>

But the manpage suggests that "alias" might contain "localhost". On our 
machines it contains the "name" we assigned the machine.

So, I think my hosts is screwed (because I don't have the .localdomain bit), 
but I think Ubuntu is correct, and using the FQDN is not actually as 
intuitive as you might think.

For identification purposes, an "alias" is probably more useful (in general) 
than the FQDN, because the FQDN may well be something meaningless like 
localhost.localdomain, which is "fully qualified" but isn't a _unique_ 
machine name, and thus not really a valid domain in a network context.

(The 'hostname' utility from net-tools is using the "canonical hostname" 
from /etc/hosts as the value for the FQDN, but gethostname() for the regular 
hostname.)

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
