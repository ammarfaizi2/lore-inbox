Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263342AbTJQJHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbTJQJHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:07:42 -0400
Received: from holomorphy.com ([66.224.33.161]:8583 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263342AbTJQJHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:07:42 -0400
Date: Fri, 17 Oct 2003 02:10:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7-mm1
Message-ID: <20031017091042.GE25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031015013649.4aebc910.akpm@osdl.org> <1066232576.25102.1.camel@telecentrolivre> <20031015165508.GA723@holomorphy.com> <200310171258.11519.dev@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310171258.11519.dev@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, akpm wrote:
>> Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
>> patches were not so great and need to be reverted.

On Fri, Oct 17, 2003 at 12:58:11PM +0400, Kirill Korotaev wrote:
> I found another bug in invalidate_inodes-speedup.patch
> introduced by WLI when doing forward porting:
> -			list_del(&inode->i_list);
> +			list_del(&inode->i_sb_list);
> first list_del should be kept!!!
> Patch fixing this issue and hugetlbfs is attached.

Aha! Thanks for cleaning up after, I've had *ahem* distractions the
past few days and haven't really been able to do much more than punt.


-- wli
