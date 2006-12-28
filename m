Return-Path: <linux-kernel-owner+w=401wt.eu-S1754900AbWL1Qbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbWL1Qbf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754894AbWL1Qbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 11:31:35 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:59446 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbWL1Qbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 11:31:34 -0500
Date: Thu, 28 Dec 2006 17:22:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christoph Hellwig <hch@infradead.org>
cc: Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
In-Reply-To: <20061228115747.GB25644@infradead.org>
Message-ID: <Pine.LNX.4.61.0612281721170.23545@yvahk01.tjqt.qr>
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com>
 <20061228084252.GG6971@in.ibm.com> <20061228115747.GB25644@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 28 2006 11:57, Christoph Hellwig wrote:
>
>> +
>> +		if ((error = __lock_page(page, current->io_wait))) {
>> +			goto readpage_error;
>> +		}
>
>This should  be
>
>		error = __lock_page(page, current->io_wait);
>		if (error)
>			goto readpage_error;

That's effectively the same. Essentially a style thing, and I see if((err =
xyz)) not being uncommon in the kernel tree.


	-`J'
-- 
