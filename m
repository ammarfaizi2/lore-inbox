Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUDOVLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUDOVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:11:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:11019 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263685AbUDOVLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:11:19 -0400
Message-ID: <407EFAAB.7060307@techsource.com>
Date: Thu, 15 Apr 2004 17:12:11 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Lazy NUMA sorting?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I understand that the 2.6 SMP balancer redistributes workload on a 
periodic basis.  Once every second or something, it migrates processes.

A NUMA system would have to do something similar, where if there is a 
page which is referenced by only one process, and the page is located on 
the "wrong" node, it could be migrated.  This could be done gradually by 
a periodic background process.  Is this already how it works?

Also, if a page is being referenced by multiple nodes, the same 
background process could make mirror copies.  (Age of page would be an 
important consideration here so moves don't happen for short-lived pages.)

