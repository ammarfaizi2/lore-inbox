Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJETgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJETgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJETgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:36:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6848 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261875AbUJETgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:36:44 -0400
Message-ID: <4162F78C.9020606@sgi.com>
Date: Tue, 05 Oct 2004 14:35:40 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: cngam@sgi.com, Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <iod00d@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C900@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0221C900@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>Yes, after looking at Grant's review/suggestion, we found that we can 
>>actually just use raw_pci_ops.  This will work well for us.  We have 
>>incoorporated this change.  No changes in pci/pci.c needed.
> 
> 
> Good.  Let's try to make some forward progress here.  I'd like
> to see the patches broken into a sequence something like this:
> 
> 1) Add new interfaces to header files to support any new API
>    needed by new files
> 2) Create all the new files (plain copies of old files where
>    a move is involved).
> 3) Functional changes to copied files.
> 4) Whitespace cleanup of copied files.
> 5) Point Makefiles to new files
> 6) Delete all the old/unused files.
> 7) Delete any API in headers that were only used by old files.
> 
> We'll need to coordinate with some other maintainrs for
> drivers/pci/hotplug/Kconfig and drivers/scsi/qla1280.c,
> but I'm ok with running all the other parts through the
> ia64 tree.
> 
> This follows the usual guidelines of a sequence of steps where
> the system is buildable+usable at each stage.
> 

Tony,

It had been suggested that we submit this as new code - since it can't be transitioned to. And I 
thought that was what we had decided on - a 'kill' patch and an 'add' patch. I can remove any 
Lindent'ing of older files if you don't want that. I will take out the Kconfig mod. I believe 
Christoph is the maintainer of the qla driver (he was one of the reviewers).

-- Pat
