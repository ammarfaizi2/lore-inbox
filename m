Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317274AbSFCFJW>; Mon, 3 Jun 2002 01:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317275AbSFCFJV>; Mon, 3 Jun 2002 01:09:21 -0400
Received: from holomorphy.com ([66.224.33.161]:26787 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317274AbSFCFJV>;
	Mon, 3 Jun 2002 01:09:21 -0400
Date: Sun, 2 Jun 2002 22:08:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: make memclass() an inline functino
Message-ID: <20020603050838.GF14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
In-Reply-To: <20020602233336.GC14918@holomorphy.com> <1023066561.23878.54.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 00:33, William Lee Irwin III wrote:
>> memclass is too large to be a #define; it overflows 80 columns and does
>> not make use of facilities available only to macros.
>> This patch convert memclass() to be an inline function.

On Mon, Jun 03, 2002 at 02:09:21AM +0100, Alan Cox wrote:
> Exercise care when doing this. Gcc sometimes optimises macros better
> than it optimises inline functions

I'll go over the assembly generated for i386, though I'm not entirely
convinced this is exercised in the fast path.

Cheers,
Bill
