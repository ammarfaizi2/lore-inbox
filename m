Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTF1W5J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbTF1W5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:57:09 -0400
Received: from holomorphy.com ([66.224.33.161]:54169 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265444AbTF1W5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:57:06 -0400
Date: Sat, 28 Jun 2003 16:11:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030628231113.GZ26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com> <20030628155436.GY20413@holomorphy.com> <20030628160013.46a5b537.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628160013.46a5b537.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  Here's highpmd.

On Sat, Jun 28, 2003 at 04:00:13PM -0700, Andrew Morton wrote:
> I taught patch-scripts a new trick:
> check_patch()
> {
> 	if grep "^+.*[ 	]$" $P/patches/$1.patch
> 	then
> 		echo warning: $1 adds trailing whitespace
> 	fi
> }

William Lee Irwin III <wli@holomorphy.com> wrote:
> +       if (pmd_table != pmd_offset_kernel(pgd, 0)) 
> +       pmd = pmd_offset_kernel(pgd, address);         
> +#define __pgd_page(pgd)                (__bpn_to_ba(pgd_val(pgd))) 

On Sat, Jun 28, 2003 at 04:00:13PM -0700, Andrew Morton wrote:
> warning: highpmd adds trailing whitespace
> You're far from the worst.   There's some editor out there which
> adds trailing tabs all over the place.  I edited the diff.

This is not my editor; it is either a manual screwup or cut and paste
(inside vi(1) and/or ed(1) buffers) of code which did so beforehand.

Thanks for cleaning that up for me; it's one of my own largest pet
peeves and I'm not terribly pleased to hear I've committed it (though
I'll not go so far as to shoot the messenger).


On Sat, Jun 28, 2003 at 04:00:13PM -0700, Andrew Morton wrote:
> What architectures has this been tested on?

i386 only, CONFIG_HIGHMEM64G with various combinations of highpte &
highpmd, and nohighmem. No CONFIG_HIGHMEM4G or non-i386 machines that
can run 2.5.x are within my grasp (obviously CONFIG_HIGHMEM4G machines
could, I just don't have them, and the discontig code barfs on mem=).


-- wli
