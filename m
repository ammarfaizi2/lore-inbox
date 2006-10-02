Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWJBU35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWJBU35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWJBU34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:29:56 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:63655 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S964980AbWJBU34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:29:56 -0400
Date: Mon, 2 Oct 2006 13:12:55 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Phillip Susi <psusi@cfl.rr.com>
cc: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
In-Reply-To: <45217498.8060806@cfl.rr.com>
Message-ID: <Pine.LNX.4.63.0610021310150.28876@qynat.qvtvafvgr.pbz>
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> 
  <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>  <45212D5D.7010201@cfl.rr.com>
  <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz> <45217498.8060806@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no, I was suggesting a pack file that contained _only_ the head version.

within the pack file it would delta against other files in the pack (how many 
copies of the GPLv2 text exist across all files for example)

however Willy did a test and found that the resulting pack was significantly 
larger then a .tgz. I don't know what options he used, so while there's some 
chance that being more agressive in looking for deltas would result in an 
improvement, the difference to make up is fairly significant.

David Lang

On Mon, 2 Oct 2006, Phillip Susi wrote:

> Date: Mon, 02 Oct 2006 16:20:40 -0400
> From: Phillip Susi <psusi@cfl.rr.com>
> To: David Lang <dlang@digitalinsight.com>
> Cc: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
>     linux-kernel@vger.kernel.org
> Subject: Re: Smaller compressed kernel source tarballs?
> 
> It sounded like you were talking about a modified pack file that did NOT 
> contain everything you need to get the current source.  You said it would 
> have no history and use aggressive delta compression to achieve a smaller 
> size than a full tarball.  If the pack contains the full previous version and 
> the delta to the head version, then it will be larger than the tar, not 
> smaller.
>
> David Lang wrote:
>> On Mon, 2 Oct 2006, Phillip Susi wrote:
>> 
>>> David Lang wrote:
>>>> I just had what's probably a silly thought.
>>>> 
>>>> as an alturnative to useing tar, what about useing a git pack?
>>>> 
>>>> create a git archive with no history, just the current files, and then 
>>>> pack it with agressive delta options.
>>>> 
>>> 
>>> Isn't that what a patch.gz is?  Diff generates the deltas and then they 
>>> are compressed.  Can't get much simpler or better than that.
>> 
>> not quite, a git pack includes everythign you need to get the full source, 
>> a patch.gz requires that you have the prior version of the source to start 
>> with.
>> 
>> David Lang
>
>
