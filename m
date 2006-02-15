Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWBOSOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWBOSOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWBOSOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:14:54 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12427 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751212AbWBOSOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:14:54 -0500
Date: Wed, 15 Feb 2006 10:14:49 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: bharata@in.ibm.com, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602151221.53730.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602151010290.6920@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <20060215054620.GA2966@in.ibm.com>
 <20060215103813.GD2966@in.ibm.com> <200602151221.53730.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006, Andi Kleen wrote:

> How about the appended patch? Does it fix the problem for you?

I think we still need to address the issue of being able to crash
the page allocator if an empty zone is in the zonelist. 

> This should work fine for now, but whoever implements node hot removal
> needs to fix this somewhere else too (or make sure zone datastructures 
> by itself never go away, only their memory)

Yup. Simply initializing the pcp structures with empty lists should 
suffice though.

