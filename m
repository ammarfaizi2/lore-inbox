Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264738AbUEEQ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264738AbUEEQ7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264741AbUEEQ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:59:10 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:17596 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264738AbUEEQ7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:59:05 -0400
To: maneesh@in.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Sensitivity: 
Subject: Re: [RFC 0/6] sysfs backing store ver 0.5
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
From: Christian Borntraeger <CBORNTRA@de.ibm.com>
Message-ID: <OF4C6C32EB.E73396AD-ON42256E8B.00597591-42256E8B.005D486F@de.ibm.com>
Date: Wed, 5 May 2004 18:59:01 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 05/05/2004 18:59:01,
	Serialize complete at 05/05/2004 18:59:01
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote:

> Hi,
> 
> The following patch set contains ver 0.5 patches implementing sysfa 
backig
> store for leaf sysfs entries. There have been changed from previuos
> version based on the comments from Al Viro. The main changes are

We already tested former versions of this patch with great success. We 
saved about 50 MB of memory on our typical S390 scenario -per LPAR. As 
there are 30 possible LPAR that can share all SAN/network devices we save 
about 30*50=1500MB of unswappable dentry/inode cache memory. Therefore 
other architectures with partitions should test this patch as well. It 
would also be nice to have some experience on x86. 
I consider this patch almost a must for s390/zSeries if there is SANs with 
shared DASDs. I made a short acceptance test of this version - more stress 
will follow. If I encounter problems I will report these to Maneesh to 
solve these problems.


cheers

-- 

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer System Evaluation
Linux for zSeries
email: CBORNTRA@de.ibm.com
Tel +49  7031 16 1975


