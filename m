Return-Path: <linux-kernel-owner+willy=40w.ods.org-S280218AbUKBBnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S280218AbUKBBnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S291827AbUKBBnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:43:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:44503 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S276105AbUKBBnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 20:43:16 -0500
Message-ID: <4186E62E.9000609@us.ibm.com>
Date: Mon, 01 Nov 2004 17:43:10 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brent Casavant <bcasavan@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hugh@veritas.com,
       ak@suse.de
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Casavant wrote:
> This patch causes memory allocation for tmpfs files to be distributed
> evenly across NUMA machines.  In most circumstances today, tmpfs files
> will be allocated on the same node as the task writing to the file.
> In many cases, particularly when large files are created, or a large
> number of files are created by a single task, this leads to a severe
> imbalance in free memory amongst nodes.  This patch corrects that
> situation.

Why don't you just use the NUMA API in your application for this?  Won't 
this hurt any application that uses tmpfs and never leaves a node in its 
lifetime, like a short gcc run?
