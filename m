Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUDZVYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUDZVYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUDZVYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 17:24:49 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:59093 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263563AbUDZVYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 17:24:44 -0400
Subject: Re: Unable to read UDF fs on a DVD
From: Pat LaVarre <p.lavarre@ieee.org>
To: gerrit.scholl@philips.com
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       linux_udf@hpesjro.fc.hp.com
In-Reply-To: <OF7EE48D71.4DD148E6-ONC1256E82.003678FE-C1256E82.0038D7EE@phil
	i ps.com>
References: <OF7EE48D71.4DD148E6-ONC1256E82.003678FE-C1256E82.0038D7EE@phili
	 ps.com>
Content-Type: text/plain
Organization: 
Message-Id: <1083014665.2945.16.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Apr 2004 15:24:25 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2004 21:24:43.0263 (UTC) FILETIME=[E41180F0:01
	C42BD4]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:14.89781 C:49 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So concluding, I see no reason why this disc is not correctly
> read by Linux UDF.

Thanks for explaining.

I remember separately I saw the famous Ben F guess that the unamerican
chars were at issue: maybe the truthful or slanderous rumours of UDF in
2004 tripping over unamerican chars as often as other software does have
substance.

I imagine to experiment we may need to bring both Windows and Linux
together: either alone might convert between bytes and chars in a
lossless consistent way that only happened not to be standard.

> > $ egrep -i '(info|warning|error):'
> http://web.tiscali.it/kronoz/ucf_test.log
> >         PVD  72  Warning: Volume Set Identifier: "040420_0906",
> >         PVD  72  Warning: Volume Set Identifier: "040420_0906",
> >         Error: Number of AVDPs less than 2: 1, AVDP at 256
> > $
> > 
> > Non-compliance! ... I'm guessing ... Not explain the ls failure, 
> ...
> This error is no problem at all, nor are the warnings.
> The 2nd AVDP is required by UDF but redundant. It is only required to
> cope with the situation that the 1st AVDP at 256 is not readable.
> 
> No UDF implementation should refuse to mount because of this.

Lost me, help?

"No problem at all"?!?

We're discussing NON COMPLIANCE ... are we not?

That is, we're discussing a plain failure to meet the requirement,
tolerated because, by design, less than all actual UDF implementations
actually require all the published requirements.

Indeed, we know some programmers prefer to write code to comply only
with the de jure theory of the merely public specifications ... rather
than writing code that consciously quietly tolerates and thereby
encourages continuing violations of those specifications.

How then can we flatly say no UDF implementation should refuse to mount
because of a missing redundant AVDP?

Why can't someone reasonably choose to make their UDF more trustworthy
and simultaneously less friendly by requiring the redundant AVDP to be
present and in agreement?

Why must everyone trust the failure model that says the missing AVDP
doesn't matter?

Indeed, someone could reasonably require the Philips UDF Verifier to
bless a disc before automounting that disc.  No?

> ...

All that said, then yes for this specific case of Linux UDF, I agree
with you, Linux by design interoperates well with Windows, both as
delivered from Microsoft and as commonly patched, so here the de facto
standard of:
 
UDF IUVD LVInfo1: "!roxioUDF!n>2173136!s>0!d>286!"

wins over the de jure theory of a requirement for two redundant AVDP.

> 	PVD  72  Warning: Volume Set Identifier: "040420_0906",
> -		 expected: CS0 representation of unique hex number in
> -			   first 8 character positions, UDF 2.2.2.5.

Again the de jure theory of conformant VSID loses to the de facto
interoperability of tolerating such abuse?

> > >  Il volume nell'unita` D e` CDROM
> > >  Numero di serie del volume: A381-DC88
> > >  Directory di D:\
> > > 10/04/2004  20.59       240.695.296 Bakuretsu Tenshi - 01.avi
> > > 16/04/2004  15.13       240.715.776 Bakuretsu Tenshi - 02.avi
> > > 13/04/2004  18.57       182.452.224 Full Metal Alchemist - 11.avi
> > > ...
> 
> The Windows dir listing as reported by Luca is exactly what is
> reported by
> the UDF verifier.

"Thanks for explaining."

> The timestamps look different, but that is because the UDF
> verifier reports in UCT by default. With the '-localtime' option, also
> the times would be identical.

"Thanks for explaining."

> cc: linux_udf@h..., linux_udf-owner@h...

I hope I did right by deleting the linux_udf-owner from the cc.

Pat LaVarre


