Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423778AbWJaSpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423778AbWJaSpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423783AbWJaSph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:45:37 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:7163 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1423778AbWJaSph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:45:37 -0500
Message-ID: <454799D8.1060908@cfl.rr.com>
Date: Tue, 31 Oct 2006 13:45:44 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Reading a bunch of file as fast a possible
References: <20061031172258.GB8230@dspnet.fr.eu.org>
In-Reply-To: <20061031172258.GB8230@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 18:45:48.0739 (UTC) FILETIME=[C8431930:01C6FD1C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14784.003
X-TM-AS-Result: No--5.767200-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it sounds like you are looking for aio, possibly with O_DIRECT if 
you would prefer that the reads not churn the cache.

Olivier Galibert wrote:
> After searching for kinda-keywords in a locked-in-memory index, I get
> a list of 50-100 files out of several hundred thousands I want to read
> as fast as possible.  I can ensure that the directory structure in hot
> in the dcache by re-reading it from time to time, but there isn't
> enough memory to lock the documents there.  So I'd like to read 50-100
> files for which I have the sizes (I put them in the index) and memory
> space as fast as possible (less than 0.1s would be great) from
> cold-ish cache.
> 
> The best way is I think to find a way to give all the requests to the
> system and have it sort them optimally at the elevator level.  But how
> can I do that?  Can aio do it, or something else?
> 
>   OG.

