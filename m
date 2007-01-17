Return-Path: <linux-kernel-owner+w=401wt.eu-S932637AbXAQTuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbXAQTuA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbXAQTt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:49:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44698 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932637AbXAQTt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:49:59 -0500
Date: Wed, 17 Jan 2007 14:46:01 -0500 (EST)
From: Chip Coldwell <coldwell@redhat.com>
To: Chip Coldwell <coldwell@redhat.com>
cc: Andi Kleen <ak@suse.de>, Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
In-Reply-To: <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701171445120.18888@localhost.localdomain>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <45AD2D00.2040904@scientia.net>
 <20070116203143.GA4213@tuatara.stupidest.org> <200701170829.54540.ak@suse.de>
 <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jan 2007, Chip Coldwell wrote:

> On Wed, 17 Jan 2007, Andi Kleen wrote:
>
>> On Wednesday 17 January 2007 07:31, Chris Wedgwood wrote:
>>> On Tue, Jan 16, 2007 at 08:52:32PM +0100, Christoph Anton Mitterer wrote:
>>>> I agree,... it seems drastic, but this is the only really secure
>>>> solution.
>>> 
>>> I'd like to here from Andi how he feels about this?  It seems like a
>>> somewhat drastic solution in some ways given a lot of hardware doesn't
>>> seem to be affected (or maybe in those cases it's just really hard to
>>> hit, I don't know).
>> 
>> AMD is looking at the issue. Only Nvidia chipsets seem to be affected,
>> although there were similar problems on VIA in the past too.
>> Unless a good workaround comes around soon I'll probably default
>> to iommu=soft on Nvidia.
>> 
>
> We've just verified that configuring the graphics aperture to be
> write-combining instead of write-back using an MTRR also solves the
> problem.  It appears to be a cache incoherency issue in the graphics
> aperture.

I take it back.  Further testing has revealed that this does not solve
the problem.

Chip

-- 
Charles M. "Chip" Coldwell
Senior Software Engineer
Red Hat, Inc
978-392-2426

