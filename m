Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267404AbUJGPlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267404AbUJGPlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUJGPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:40:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:52702 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267396AbUJGPkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:40:32 -0400
Subject: Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
From: Dave Hansen <haveblue@us.ibm.com>
To: Matthew E Tolentino <matthew.e.tolentino@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1097163578.3625.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 08:39:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 08:03, Tolentino, Matthew E wrote:
> >> Followings are patches for removing bitmaps from buddy=20
> >allocator, against 2.6.9-rc3.
> >> I think this version is much clearer than ones I posted a month ago.
> >...
> >> If there is unclear point, please tell me.
> >
> >What was the purpose behind this, again? Sorry, has been too long since
> >I last looked.
> 
> For one, it avoids the otherwise requisite resizing of the bitmaps=20
> during memory hotplug operations...

It also simplifies the nonlinear implementation.  The whole reason we
had the lpfn (Linear) stuff was so that the bitmaps could represent a
sparse physical address space in a much more linear fashion.  With no
bitmaps, this isn't an issue, and gets rid of a lot of code, and a
*huge* source of bugs where lpfns and pfns are confused for each other. 
-- Dave

