Return-Path: <linux-kernel-owner+w=401wt.eu-S932593AbXAQSLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXAQSLU (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 13:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbXAQSLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 13:11:20 -0500
Received: from mail.tmr.com ([64.65.253.246]:46870 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593AbXAQSLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 13:11:19 -0500
Message-ID: <45AE6759.70108@tmr.com>
Date: Wed, 17 Jan 2007 13:13:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "obsolete" versus "deprecated", and a new config option?
References: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701171134440.1878@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   a couple random thoughts on the notion of obsolescence and
> deprecation.

	[...horrible example deleted...]

>   so is that ioctl obsolete or deprecated?  those aren't the same
> things, a good distinction being drawn here by someone discussing
> devfs:
> 
> http://kerneltrap.org/node/1893
> 
> "Devfs is deprecated.  This means it's still available but you should
> consider moving to other options when available.  Obsolete means it
> shouldn't be used.  Some 2.6 docs have confused these two terms WRT
> devfs."
> 
>   yes, and that confusion continues to this day, when a single feature
> is described as both deprecated and obsolete.  not good.  (also, i'm
> guessing that anything that's "obsolete" might deserve a default of
> "n" rather than "y", but that's just me.  :-)

Agree on that. I would hope "obsolete" means there's a newer way which 
should provide the functionality (** help should say where that is **) 
while depreciated should mean "we decided this was a bad solution" or 
something like that.
> 
>   in any event, what about introducing a new config variable,
> OBSOLETE, under "Code maturity level options"?  this would seem to be
> a quick and dirty way to prune anything that is *supposed* to be
> obsolete from the build, to make sure you're not picking up dead code
> by accident.

If you're doing that, why not four variables, for incomplete, 
experimental, obsolete and depreciated? Unfortunately doing any more 
detailed nomenclature would be a LOT of work!
> 
>   i think it would be useful to be able to make that kind of
> distinction since, as the devfs writer pointed out above, the point of
> labelling something "obsolete" is not to *discourage* someone from
> using a feature, it's to imply that they *shouldn't* be using that
> feature.  period.  which suggests there should be an easy, one-step
> way to enforce that absolutely in a build.
> 
>   thoughts?
> 
I think it's a good idea, but doing it right may be more work than the 
benefit justifies.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
