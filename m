Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUD2Uxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUD2Uxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUD2Uug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:50:36 -0400
Received: from mail.fastclick.com ([205.180.85.17]:52436 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264781AbUD2UsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:48:23 -0400
Message-ID: <409169F0.1020902@fastclick.com>
Date: Thu, 29 Apr 2004 13:47:44 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <40904FD8.7020208@fastclick.com> <20040428181319.601decfc.akpm@osdl.org> <40905A5E.5000807@fastclick.com> <409143F6.3050300@fastclick.com> <20040429183226.GA783@holomorphy.com>
In-Reply-To: <20040429183226.GA783@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> On Thu, Apr 29, 2004 at 11:05:42AM -0700, Brett E. wrote:
> 
>>Anyone know what I should believe?  Sar's pgpgin/s and pgpgout/s tell me 
>> that it is paging in/out from/to disk.  Yet pswpin/s and pswpout/s are 
>>both 0.  Swapping and paging are the same thing I believe. pgpgin/out 
>>refer to paging, pswpin/out refer to swapping.  So I for one am confused.
>>I guess I could dig through the source but I figured someone might have 
>>encountered this disrepency in the past.
> 
> 
> Both are to be believed. They merely describe different things.
> 
> Pagein/pageout are counts of VM-initiated IO, regardless of whether this
> IO is done on filesystem-backed pages or swap-backed pages. Pagein and
> pageout are used more generally to describe VM-initiated IO and don't
> exclusively refer to swap IO, but also include IO to filesystems to/from
> filesystem-backed memory.
> 
> Swapin/swapout are counts of swap IO only, and are considered to apply
> only to IO done to swap files/devices to/from swap-backed anonymous memory.
> 
> Pagein/pageout are both proper and necessary to have. In fact, you were
> requesting that filesystem IO be done preferentially to swap IO, and the
> pagein/pageout indicators showing IO while swapin/swapout indicators show
> none mean you are getting exactly what you asked for.
> 
> 
Thanks I think it's clear now. In layman's terms, pgpgin/out relate to 
disk cache activity vs pswpin/out which relate to swap activity.

