Return-Path: <linux-kernel-owner+w=401wt.eu-S965090AbWLMTQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWLMTQB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWLMTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:16:01 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:8963 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965088AbWLMTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:16:00 -0500
X-Greylist: delayed 847 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 14:16:00 EST
Message-ID: <45804E3C.9020105@cfl.rr.com>
Date: Wed, 13 Dec 2006 14:02:20 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Nikolai Joukov <kolya@cs.sunysb.edu>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       unionfs@filer.fsl.cs.sunysb.edu, fistgen@filer.fsl.cs.sunysb.edu
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612122217360.22195@compserv1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2006 19:02:06.0401 (UTC) FILETIME=[2EC1BB10:01C71EE9]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14870.003
X-TM-AS-Result: No--6.887800-5.000000-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolai Joukov wrote:
> replication.  In case of RAID4 and RAID5-like configurations, RAIF performed
> about two times *better* than software RAID and even better than an Adaptec
> 2120S RAID5 controller.  This is because RAIF is located above file system
> caches and can cache parity as normal data when needed.  We have more
> performance details in a technical report, if anyone is interested.

This doesn't make sense to me.  You do not want to cache the parity 
data.  It only needs to be used to validate the data blocks when the 
stripe is read, and after that, you only want to cache the data, and 
throw out the parity.  Caching the parity as well will pollute the cache 
and thus, should lower performance due to more important data being 
thrown out.




