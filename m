Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbSJMUkf>; Sun, 13 Oct 2002 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJMUkf>; Sun, 13 Oct 2002 16:40:35 -0400
Received: from holomorphy.com ([66.224.33.161]:13707 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261675AbSJMUke>;
	Sun, 13 Oct 2002 16:40:34 -0400
Date: Sun, 13 Oct 2002 13:42:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.42-mm2
Message-ID: <20021013204244.GD2032@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20021013195236.GC27878@holomorphy.com> <Pine.LNX.4.44L.0210131803400.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210131803400.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, William Lee Irwin III wrote:
>> (1) It's embedded in struct zone, hence bootmem allocated, hence
>> 	already zeroed.

On Sun, Oct 13, 2002 at 06:04:02PM -0200, Rik van Riel wrote:
> The struct zone doesn't get automatically zeroed on all architectures.

It actually doesn't come out of bootmem. It's tacked onto min_low_pfn
because it's being dynamically allocated prior to init_bootmem().


Bill
