Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbUJZCZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbUJZCZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 22:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbUJZCYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:24:44 -0400
Received: from holomorphy.com ([207.189.100.168]:44768 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262200AbUJZCX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 22:23:29 -0400
Date: Mon, 25 Oct 2004 19:23:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
Message-ID: <20041026022322.GD17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> - memory policy for numa alloc is only available in mempolicy.c and
> not in hugetlb.c If hugepage allocation needs to follow mempolicy
> then we need additional stuff in mempolicy.c exported (defer for now).

Exported? hugetlb hasn't ever really successfully been made modular.


On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> - Do other arch specific functions need to be aware of compound pages for
>   this to work?

Not sure where any new dependencies would come in, or even what "this"
means in your question.


On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> - Clearing hugetlb pages is time consuming using clear_highpage in
> alloc_huge_page. Make it possible to use hw assist via DMA or so there?

It's possible, but it's been found not to be useful. What has been found
useful is assistance from much lower-level memory hardware of a kind
not to be had in any extant mass-manufactured machines.


On Mon, Oct 25, 2004 at 06:26:42PM -0700, Christoph Lameter wrote:
> - sparc64 arch code needs to be tested
> - sh64 code needs to be fixed up and tested
> - sh code needs to be fixed up and tested

I'll ask the maintainers where to get sh and sh64 hardware.


-- wli
