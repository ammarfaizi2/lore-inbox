Return-Path: <linux-kernel-owner+w=401wt.eu-S932849AbWL1Jyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWL1Jyk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbWL1Jyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:54:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55067 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932805AbWL1Jyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:54:39 -0500
Date: Thu, 28 Dec 2006 10:52:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, akpm@osdl.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20061228095205.GG24765@elte.hu>
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228082308.GA4476@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> The following is a sampling of comparative aio-stress results with the 
> patches (each run starts with uncached files):
> 
> ---------------------------------------------
> 				
> aio-stress throughput comparisons (in MB/s):
> 
> file size 1GB, record size 64KB, depth 64, ios per iteration 8
> max io_submit 8, buffer alignment set to 4KB
> 4 way Pentium III SMP box, Adaptec AIC-7896/7 Ultra2 SCSI, 40 MB/s
> Filesystem: ext2
> 
> ----------------------------------------------------------------------------
> 			Buffered (non O_DIRECT)
> 			Vanilla		Patched		O_DIRECT
> ----------------------------------------------------------------------------
> 						       Vanilla Patched
> Random-Read		10.08		23.91		18.91,   18.98
> Random-O_SYNC-Write	 8.86		15.84		16.51,   16.53
> Sequential-Read		31.49		33.00		31.86,   31.79
> Sequential-O_SYNC-Write  8.68		32.60		31.45,   32.44
> Random-Write		31.09 (19.65)	30.90 (19.65)	
> Sequential-Write	30.84 (28.94)	30.09 (28.39)

the numbers look very convincing to me!

	Ingo
