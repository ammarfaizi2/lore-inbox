Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUCQU62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCQU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:58:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18151 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262065AbUCQU6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:58:22 -0500
Date: Wed, 17 Mar 2004 12:58:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Picco <Robert.Picco@hp.com>
cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, haveblue@us.ibm.com
Subject: Re: boot time node and memory limit options
Message-ID: <3580000.1079557089@flay>
In-Reply-To: <4058AE91.8000909@hp.com>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com> <34060000.1079465992@flay> <405879BC.7060904@hp.com> <1745150000.1079541412@[10.10.2.4]> <4058A75A.3080409@hp.com> <2611830000.1079552673@[10.10.2.4]> <4058AE91.8000909@hp.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes ... that's looking very 2.7-ish to reorganise all that stuff. However,
>> for now, I still think we need to restrict memory very early on, before 
>> anything else can allocate bootmem. Are you the absolute first thing that
>> ever runs in the boot allocator?
>> 
>> M.
>>  
>> 
> All the machine dependent initialization code could have allocated and/or reserved bootmem  before the patch would claim additional memory based on boot line parameters.  The patch is  called just before mem_init.  There aren't any pages on freelist yet because mem_init hasn't been called. So I'm not the first thing that ever runs in the boot allocator.  I'm not sure that my answer is addressing your question?

You are, but it's not the answer I want ;-) If you can allocate stuff out
of bootmem that should have been barred by the limiter, I think that's
a bad idea ... you should be restricting earlier, IMHO.

M.

