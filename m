Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDOOX5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbTDOOX5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:23:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:1717 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261572AbTDOOX4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:23:56 -0400
Date: Tue, 15 Apr 2003 07:35:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Duncan Sands <baldrick@wanadoo.fr>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUGed to death
Message-ID: <69850000.1050417343@[10.10.2.4]>
In-Reply-To: <200304151401.00704.baldrick@wanadoo.fr>
References: <80690000.1050351598@flay>
 <200304151401.00704.baldrick@wanadoo.fr>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Seems all these bug checks are fairly expensive. I can get 1%
>> back on system time for kernel compiles by changing BUG to
>> "do {} while (0)" to make them all compile away. Profiles aren't
>> very revealing though ... seems to be within experimental error ;-(
> 
> What happens if you just turn BUG_ON into "do {} while (0)"?

I believe I already did that by turning BUG() into a null expression.

#define BUG_ON(condition) 
	do { if (unlikely((condition)!=0)) BUG(); } while(0)

The compiler should be smart enough to optimise that away, methinks.

M.
