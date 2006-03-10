Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWCJE5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWCJE5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWCJE5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:57:15 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:49550 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751384AbWCJE5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:57:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=f85DNnkCadIVpI7wP0eKzfYcJnFzykr8zAp+wrsL/LWkVFv9+jPm8QDJh+lYva/I+sLDFIFHWQYNW+uWmTSuejb/nfqQfv8yTapRzgb4TbFp1NbGnPO2wrV7fiyEOmmU/XdUQ7E5y9owwlI1X7gehYCRp+UW/DUBFkfj/Eib+wo=  ;
Message-ID: <44110727.802@yahoo.com.au>
Date: Fri, 10 Mar 2006 15:57:11 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus@valinux.co.jp>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 03/03] Unmapped: Add guarantee code
References: <20060310034412.8340.90939.sendpatchset@cherry.local> <20060310034429.8340.61997.sendpatchset@cherry.local>
In-Reply-To: <20060310034429.8340.61997.sendpatchset@cherry.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm wrote:
> Implement per-LRU guarantee through sysctl.
> 
> This patch introduces the two new sysctl files "node_mapped_guar" and
> "node_unmapped_guar". Each file contains one percentage per node and tells
> the system how many percentage of all pages that should be kept in RAM as 
> unmapped or mapped pages.
> 

The whole Linux VM philosophy until now has been to get away from stuff
like this.

If your app is really that specialised then maybe it can use mlock. If
not, maybe the VM is currently broken.

You do have a real-world workload that is significantly improved by this,
right?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
