Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWJBPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWJBPQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWJBPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:16:40 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:59592 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932521AbWJBPQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:16:39 -0400
Message-ID: <45212D5D.7010201@cfl.rr.com>
Date: Mon, 02 Oct 2006 11:16:45 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0610012205280.28534@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Oct 2006 15:16:46.0504 (UTC) FILETIME=[C6872A80:01C6E635]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14726.003
X-TM-AS-Result: No--11.503100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I just had what's probably a silly thought.
> 
> as an alturnative to useing tar, what about useing a git pack?
> 
> create a git archive with no history, just the current files, and then 
> pack it with agressive delta options.
> 

Isn't that what a patch.gz is?  Diff generates the deltas and then they 
are compressed.  Can't get much simpler or better than that.

> since git uses compression on the result anyway it's unlikly to be much 
> worse then a tarball, and since it can use deltas across files it may 
> even be better (potentially enough better to cover the cost of 
> downloading the git binaries)
> 
> this would be especially effective once git adds a 'shallow clone' 
> capability to then take the snapshot pack and extend it (either forward 
> or backward as requested by the user), but may be worth doing even 
> without this.
> 
> thoughts?
> 
> David Lang

