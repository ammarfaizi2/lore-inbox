Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVLEVHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVLEVHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVLEVHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:07:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14052 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751473AbVLEVHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:07:01 -0500
Message-ID: <4394ABE1.4040008@us.ibm.com>
Date: Mon, 05 Dec 2005 13:06:41 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E9A886@otce2k03.adaptec.com> <438F4CDA.20604@pobox.com>
In-Reply-To: <438F4CDA.20604@pobox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

At last, I've been given the go-ahead to work on hostraid support for
dmraid.  I'll post some patches when I've made some progress.

Is linux-lvm the appropriate place for dmraid patches/discussion?  I
couldn't find any mailing lists that sounded more appropriate.

--D

Jeff Garzik wrote:
> Salyzyn, Mark wrote:
> 
>> Jeff Garzik [mailto:jgarzik@pobox.com] sez:
>>
>>> All throughout development, before Justin had written a single line
>>> of code, he was told to do things via Device Mapper.
>>
>>
>>
>> He did not strictly write the emd code, it was written years earlier by
>> a team. It's release was the result of it being placed on his lap
>> submit.
> 
> 
> Ah, I stand corrected.
> 
> I just recall being on concalls months prior to public EMD release,
> urging the use of Device Mapper, and telling Adaptec and other involved
> companies that the submission would be rejected if the current course
> was continued.
> 
> No doubt it was very frustrating for the engineers doing the work to
> have their months of effort rejected, but it was also frustrating for
> me, since I was trying make all parties aware of the impending rejection
> well in advance.
> 
> 
>> As I said, it all ended up being an unfortunate timing of events with
>> unexpected side effects. At each instant of time it has always been
>> clear what to do ...
>>
>> 2005? We tried to set up a case for ROI for the support of a dmraid
>> plugin. I am merely a JAFO to that process trying to push it along.
> 
> 
> Well, all your efforts are appreciated :)
> 
> Adaptec has an unfortunate history of simply not communicating well with
> the Linux community -- and I note that's a two-way street.  I've even
> heard it whispered that Linux people "hate Adaptec", that we take some
> sort of pleasure out of putting the screws to Adaptec.
> 
> Nothing could be further from the truth.
> 
> Exclusing you, Mark, who seems to understand this stuff, Adaptec just
> seems to have a tough time understanding the rationale and goals behind
> the feedback from SCSI and Linux maintainers.
> 
> Adaptec -- excluding aacraid -- continues to have a history of (a) being
> grossly dissatisfied with the current SCSI code, and (b) concluding that
> a proper solution simply works around all the problems.  That's a fair
> perspective, but Linux prefers the more cross-vendor approach of
> modifying the base Linux code.
> 
> Greater than Linux itself, the GPL and open source create a commodity
> effect:  competitors work on the same piece of software, rather than
> producing competing versions of software.  Out of this principle falls
> the "update SCSI core, don't workaround in your driver" approach.  Ditto
> for use of Device Mapper, rather than doing RAID in the driver itself,
> or duplicating effort with EMD.  With open source, code duplication just
> increases effort, decreases test coverage, and increases the likelihood
> of bugs.
> 
> The downside (from a vendor perspective) is that vendor engineers are
> drafted into updating the Linux core, when a new spiffy hardware feature
> needs to be supported.  This is actually not a downside, but a benefit.
>    In the long run, common code is highly reus{able,ed}, leading to
> rapid development, vastly increased test coverage, and maintainable even
> if the original hardware vendor goes out of business, or EOLs the hardware.
> 
> I wish I could rewind the clock, and demonstrate to Justin, Scott, Luben
> and other Adaptec engineers that there are solid reasons behind each of
> these decisions, and its not "politics" or "NIH" or "we hate you" or "we
> are the anointed ones, bow to us."
> 
> Linux doesn't have a roadmap, rather it has certain code patterns that
> experience has taught us are sustainable, portable, and performant in
> the long term.  As long as new source code fits these code patterns, we
> welcome the addition with open arms.  From any company.
> 
>     Jeff
> 
> 
> 
