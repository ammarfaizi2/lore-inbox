Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbUBZTIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbUBZTIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:08:14 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:59141 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262937AbUBZTII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:08:08 -0500
Message-ID: <403E4681.20603@techsource.com>
Date: Thu, 26 Feb 2004 14:18:25 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Nakajima, Jun" <jun.nakajima@intel.com>
CC: richard.brunner@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nakajima, Jun wrote:
> Thanks for the clarification.
> 
> Yes, "implementation specific" is one of the differences between IA-32e
> and AMD64, i.e. that behavior is architecturally defined on AMD64, but
> on IA-32e (as I posted): 
>   Near branch with 66H prefix:
>     As documented in PRM the behavior is implementation specific and
> should 
>     avoid using 66H prefix on near branches.


In other words, Intel's implementation deviates from the architecture as 
defined by AMD.  So it's not 100% compatible.  I just want this point to 
be clear.


If these sorts of branches are common enough (and I suspect they are), 
then this sort of deviation could have a notable code-size (and L1) 
impact on code which is compiled to be compatible with both implementations.

Why did Intel decide to do that?

