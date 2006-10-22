Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWJVXhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJVXhv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWJVXhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:37:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30929 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750764AbWJVXhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:37:51 -0400
Message-ID: <453C00B7.3040909@zytor.com>
Date: Sun, 22 Oct 2006 16:37:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Sandeep Kumar <sandeepksinha@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: PAE and PSE ??
References: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com> <200610221215.26525.rjw@sisk.pl>
In-Reply-To: <200610221215.26525.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> On Sunday, 22 October 2006 08:29, Sandeep Kumar wrote:
>> Hi all,
>> I have read in UTLK by bovet that the linux kernel does not uses the
>> PSE bit on an x86
>> machine. Then how come we have the hugetlbfs, which provides support
>> for 4MB pages ?
> 
> AFAIK, PSE is only used when PAE is not set and then it enables the 4 MB
> pages.  If PAE is set, the 4 MB pages are impossible because there are only
> 512 entries per page table, but 2 MB pages can be used instead (and you don't
> need to set PSE to use them).
> 

You're wrong.

PSE refers to 4 MB pages when PAE is not used, and 2 MB pages when PAE 
is used.

In theory, you could have PAE without PSE, which would only support 4K 
pages.

Linux uses PSE; it may or may not use PAE depending on the configuration.

	-hpa
