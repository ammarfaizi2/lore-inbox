Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVFPXDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVFPXDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFPXAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:00:19 -0400
Received: from holomorphy.com ([66.93.40.71]:16806 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261876AbVFPW6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:58:47 -0400
Date: Thu, 16 Jun 2005 15:58:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-ID: <20050616225838.GE3913@holomorphy.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com> <20050616002451.01f7e9ed.akpm@osdl.org> <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com> <20050616224230.GD3913@holomorphy.com> <1118960737.4301.483.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118960737.4301.483.camel@dyn9047017072.beaverton.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-16 at 15:42, William Lee Irwin III wrote:
>> It's because you're sorting on the third field of readprofile(1),
>> which is pure gibberish. Undoing this mistake will immediately
>> enlighten you.

On Thu, Jun 16, 2005 at 03:25:42PM -0700, Badari Pulavarty wrote:
> Hmm.. I was under the impression that its gives useful info ..
> Here is readprofile man-page says:
>        Print the 20 most loaded procedures:
>           readprofile | sort -nr +2 | head -20

Unfortunately it's bunk. Sorting by hits gives a much better idea
of where the time is going because it corresponds to time. That's
done with readprofile | sort -nr +0 | head -20


On Thu, 2005-06-16 at 15:42, William Lee Irwin III wrote:
>> Also, turn off slab poisoning when doing performance analyses.
> Its already off. I am not trying to compare performance here.
> I was trying to analyze VM behaviour with filesystem tests.
> (with "raw" devices, machine is perfectly happy - but with
> filesystem cache it crawls).

check_poison_obj(), which appears in your profile, exists only when
CONFIG_DEBUG_SLAB is set.


-- wli
