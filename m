Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUH1Ge2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUH1Ge2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267283AbUH1Ge2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:34:28 -0400
Received: from holomorphy.com ([207.189.100.168]:44196 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267251AbUH1Ge1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:34:27 -0400
Date: Fri, 27 Aug 2004 23:34:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-ID: <20040828063419.GA5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, oleg@tv-sign.ru,
	linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040828052627.GA2793@holomorphy.com> <20040828053112.GB2793@holomorphy.com> <20040827231713.212245c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827231713.212245c5.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> void fastcall unlock_page(struct page *page)
>>  {
>> +	unsigned long *word = (unsigned long *)&page->flags;

On Fri, Aug 27, 2004 at 11:17:13PM -0700, Andrew Morton wrote:
> This will break if a little-endian 64-bit architecture elects to use a
> 32-bit page_flags_t.

You mean a big-endian one? I did check to be sure none did so; only
x86-64 does. Easy enough to dress up so BE arches can do it too.


-- wli
