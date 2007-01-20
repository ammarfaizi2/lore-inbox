Return-Path: <linux-kernel-owner+w=401wt.eu-S965397AbXATVni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397AbXATVni (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 16:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965400AbXATVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 16:43:38 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:3878 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965397AbXATVnh (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 16:43:37 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sat, 20 Jan 2007 21:43:30 +0000
User-Agent: KMail/1.9.5
Cc: pomac@vapor.com, Linux-kernel@vger.kernel.org, jeff@garzik.org,
       B.Steinbrink@gmx.de, chunkeey@web.de
References: <1169305408.4199.3.camel@pi.pomac.com> <45B2748B.4060106@shaw.ca>
In-Reply-To: <45B2748B.4060106@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701202143.31256.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 January 2007 19:59, Robert Hancock wrote:
> Ian Kumlien wrote:
> > Hi,
> >
> > I went from 2.6.19+sata_nv-adma-ncq-v7.patch, with no problems and adama
> > enabled, to 2.6.20-rc5, which gave me problems almost instantly.
> >
> > I just thought that it might be interesting to know that it DID work
> > nicely.
> >
> > CC since i'm not on the ml
>
> (I'm ccing more of the people who reported this)
>
> Well that's interesting.. The only significant change that went into
> 2.6.20-rc5 in that driver that wasn't in that version you mentioned was
> this one:
>
> http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=com
>mit;h=2dec7555e6bf2772749113ea0ad454fcdb8cf861
>
> Could you (or anyone else) test what happens if you take the 2.6.20-rc5
> version of sata_nv.c and try it on 2.6.19? That would tell us whether
> it's this change or whether it's something else (i.e. in libata core).

I'm still running an -rc5 kernel with ADMA switched off entirely and I can't 
reproduce the problem. How is everybody else reproducing this?

I've been successful installing bonnie++, then going to a large XFS partition 
and running "bonnie++ -u 1000:1000" and letting it run through, all defaults.

It doesn't cause the problem I was seeing in -rc5 with ADMA on, when I switch 
ADMA off, so I think this is sufficient to fix it.

Others have reported differently. Did you guys do:

alistair@damocles:~$ cat /proc/cmdline
root=/dev/sda1 ro sata_nv.adma=0

Or something similar? This is how Jeff suggested disabling ADMA and indeed the 
messages about its use disappear from dmesg.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
