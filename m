Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTGDDjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbTGDDjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:39:24 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8895 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265726AbTGDDjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:39:24 -0400
Subject: Re: Overhead of highpte (or not :)
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <68160000.1057286782@[10.10.2.4]>
References: <574790000.1057186404@flay>
	 <1057286058.11027.106.camel@nighthawk>  <68160000.1057286782@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1057290780.18849.37.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jul 2003 20:53:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After fixing my gcc stupidity
             Elapsed:    User:   System:     CPU:
high pte:    49.962s  578.888s   99.048s  1356.2%
  lowpte:    49.630s  576.242s   90.158s  1342.0%
    ukva:    50.122s  577.164s   88.958s  1328.4%

The increase in elapsed is probably within tolerances.  The system time
isn't :)  The decrease in system time compared to lowpte comes because
the PTE pages are allocated in highmem, and are node-local.  

Differential profiles are up in a bit.

-- 
Dave Hansen
haveblue@us.ibm.com

