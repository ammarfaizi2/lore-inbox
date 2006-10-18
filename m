Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWJRQWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWJRQWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJRQWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:22:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:6064 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751487AbWJRQWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:22:21 -0400
Message-ID: <453654B7.2040607@us.ibm.com>
Date: Wed, 18 Oct 2006 11:22:15 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: David Gibson <dwg@au1.ibm.com>, Santiago Leon <santil@us.ibm.com>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: veth crash (commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773)
References: <20061012082214.GA9154@localhost.localdomain> <20061013042059.GA6500@localhost.localdomain>
In-Reply-To: <20061013042059.GA6500@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> Jeff, Santiago, please apply the patch below to correct this:
> 
> ibmveth: Fix index increment calculation
> 
> The recent commit 751ae21c6cd1493e3d0a4935b08fb298b9d89773 introduced
> a bug in the producer/consumer index calculation in the ibmveth driver
> - incautious use of the post-increment ++ operator resulted in an
> increment being immediately reverted.  This patch corrects the logic.
> 
> Without this patch, the driver oopses almost immediately after
> activation on at least some machines.
> 
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

David, I'm not sure how it got past the testing that I did, but thanks 
for catching this.

Jeff, can you apply? Thank you.

Signed-off-by: Santiago Leon <santil@us.ibm.com
-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center
