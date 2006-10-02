Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965446AbWJBV55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965446AbWJBV55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965448AbWJBV55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:57:57 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:24537 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965446AbWJBV54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:57:56 -0400
Date: Mon, 2 Oct 2006 14:42:51 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sean <seanlkml@sympatico.ca>
cc: Willy Tarreau <w@1wt.eu>, Phillip Susi <psusi@cfl.rr.com>,
       Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <BAYC1-PASMTP060E41BEECF96499D4A89EAE1F0@CEZ.ICE>  <20061002174938.bb82027d.seanlkml@sympatico.ca>
Message-ID: <Pine.LNX.4.63.0610021440120.28876@qynat.qvtvafvgr.pbz>
References: <20061002033511.GB12695@zimmer><20061002033531.GA5050@1wt.eu><Pi
 ne.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz><45212D5D.7010201@cfl.r
 r.com><Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz><45217498.8060
 806@cfl.rr.com><Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz><2006
 1002203527.GA585@1wt.eu> <BAYC1-PASMTP060E41BEECF96499D4A89EAE1F0@CEZ.ICE>
  <20061002174938.bb82027d.seanlkml@sympatico.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Oct 2006, Sean wrote:

> On Mon, 2 Oct 2006 22:35:27 +0200
> Willy Tarreau <w@1wt.eu> wrote:
>
>> On Mon, Oct 02, 2006 at 01:12:55PM -0700, David Lang wrote:
>>> no, I was suggesting a pack file that contained _only_ the head version.
>>>
>>> within the pack file it would delta against other files in the pack (how
>>> many copies of the GPLv2 text exist across all files for example)
>>>
>>> however Willy did a test and found that the resulting pack was
>>> significantly larger then a .tgz. I don't know what options he used, so
>>> while there's some chance that being more agressive in looking for deltas
>>> would result in an improvement, the difference to make up is fairly
>>> significant.
>>
>> no options at all, so there may be room for improvement. Also, on my
>> notebook, I have hardlinked all my linux directories so that each
>> content only appears once. I don't have the numbers right here, but
>> I remember that it was really useful to merge lots of different versions,
>> but that the net gain within one given tree was really minor, as there
>> are not that many identical files in one tree.
>
> Hey Willy,
>
> I don't really understand the objective here, but you may want to double
> check your procedure, the entire 2.4 history only takes a single 41M pack
> in Git for me.

the idea was to use a git pack instead of a .tgz or .tar.bz2 as a distribution 
format from kernel.org

for example, the pack would only include the 2.6.18 kernel, no history.

once git supports shallow clones then the distributed blob could be a clone seed 
that a person could download and then track changes from there forward. but 
that's a future enhancement.

David Lang
