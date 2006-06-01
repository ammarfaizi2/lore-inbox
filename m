Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWFAO7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWFAO7e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWFAO7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:59:34 -0400
Received: from dvhart.com ([64.146.134.43]:50578 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751027AbWFAO7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:59:33 -0400
Message-ID: <447F00C7.4060904@mbligh.org>
Date: Thu, 01 Jun 2006 07:59:19 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Paulo Marques <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
References: <BKEKJNIHLJDCFGDBOHGMGEIHCNAA.abum@aftek.com>
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMGEIHCNAA.abum@aftek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abu M. Muttalib wrote:
> Hi,
> 
> I am sorry to cause inconvenience. To put the doubts concisely, I am doing
> the following:
> 
> I am removing the sound driver (shipped with kernel 2.6.13) and then
> inserting the same. This all I am doing inside an infinite loop. Before this
> I have reserved and used (setting the same with memset) some 900 pages to
> simulate an application environment. I am running this application on Linux
> 2.6.13 on an ARM based target. During the course of the run I get the
> following page allocation error:
> ----------------------------------------------------------------------------
> ---------------------------------------------------------------insmod: page
> allocation failure. order:5, mode:0xd0

Order 5 allocations will never work reliably, except possibly at boot.
We don't have 32 contig pages to give you - fragmentation.

M.
