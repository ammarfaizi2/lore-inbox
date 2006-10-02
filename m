Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWJBUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWJBUU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWJBUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:20:27 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:15830 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964972AbWJBUU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:20:26 -0400
Message-ID: <45217498.8060806@cfl.rr.com>
Date: Mon, 02 Oct 2006 16:20:40 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu>  <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz> <45212D5D.7010201@cfl.rr.com> <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0610020848070.28876@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2006 20:20:40.0794 (UTC) FILETIME=[3B0303A0:01C6E660]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14726.003
X-TM-AS-Result: No--11.111400-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It sounded like you were talking about a modified pack file that did NOT 
contain everything you need to get the current source.  You said it 
would have no history and use aggressive delta compression to achieve a 
smaller size than a full tarball.  If the pack contains the full 
previous version and the delta to the head version, then it will be 
larger than the tar, not smaller.

David Lang wrote:
> On Mon, 2 Oct 2006, Phillip Susi wrote:
> 
>> David Lang wrote:
>>> I just had what's probably a silly thought.
>>>
>>> as an alturnative to useing tar, what about useing a git pack?
>>>
>>> create a git archive with no history, just the current files, and 
>>> then pack it with agressive delta options.
>>>
>>
>> Isn't that what a patch.gz is?  Diff generates the deltas and then 
>> they are compressed.  Can't get much simpler or better than that.
> 
> not quite, a git pack includes everythign you need to get the full 
> source, a patch.gz requires that you have the prior version of the 
> source to start with.
> 
> David Lang

