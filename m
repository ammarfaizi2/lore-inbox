Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbUKWTey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUKWTey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbUKWTda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:33:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51142 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261429AbUKWTbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:31:16 -0500
Message-ID: <41A3902C.60004@engr.sgi.com>
Date: Tue, 23 Nov 2004 11:31:56 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
CC: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Erik Jacobson <erikj@dbear.engr.sgi.com>
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>	 <20041123090325.GA22114@infradead.org> <1101202407.6210.87.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1101202407.6210.87.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is great!

We have one more user of PAGG! :)

Happy Thanksgiving,
  - jay


Guillaume Thouvenin wrote:
> On Tue, 2004-11-23 at 09:03 +0000, Christoph Hellwig wrote:
> 
>>On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
>>
>>>   For a module, I need to execute a function when a fork occurs. My
>>>solution is to add a pointer to a function (called fork_hook) in the
>>>do_fork() and if this pointer isn't NULL, I call the function. To update
>>>the pointer to the function I export a symbol (called trace_fork) that
>>>defines another function with two parameters (the hook and an
>>>identifier). This function provides a simple mechanism to manage access
>>>to the fork_hook variable.
>>>
>>
>>Use SGI's PAGG patches if you want such hooks.  Also this is clearly
>>a _GPL export.
> 
> 
> PAGG is more intrusive than my patch due to the management of groups of
> processes. This hook in the fork allows me to provide a solution to do
> per-group accounting with a module. If PAGG is added in the Linux Kernel
> Tree it could be the solution, you are right. 
> 
> Guillaume 
> 

