Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUJHLJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUJHLJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJHLJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:09:05 -0400
Received: from holomorphy.com ([207.189.100.168]:64725 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267746AbUJHLJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:09:02 -0400
Date: Fri, 8 Oct 2004 04:08:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __init poisoning for i386, too
Message-ID: <20041008110845.GC9106@holomorphy.com>
References: <20041006221854.GA1622@elf.ucw.cz> <20041007061610.GU9106@holomorphy.com> <ck4b39$fmp$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ck4b39$fmp$1@terminus.zytor.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Any chance we could:
>> (a) set the stuff to 0x0f0b so illegal instructions come of it; jumps are
>> 	most often aligned to something > 16 bits anyway
>> (b) poison __initdata, memsetting to some bit pattern oopsable to dereference

On Thu, Oct 07, 2004 at 09:05:45PM +0000, H. Peter Anvin wrote:
> What's wrong with using 0xCC (breakpoint instruction)?
> If you want an illegal instruction, 0xFF 0xFF is an illegal
> instruction, so filling memory with 0xFF will do what you want.

That sounds better than what I suggested.


-- wli
