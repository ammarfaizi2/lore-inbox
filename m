Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKIDGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKIDGV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 22:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbUKIDGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 22:06:21 -0500
Received: from holomorphy.com ([207.189.100.168]:30849 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261364AbUKIDGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 22:06:19 -0500
Date: Mon, 8 Nov 2004 19:05:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Willibald Krenn <Willibald.Krenn@gmx.at>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: VMM:  syscall for reordering pages in vm
Message-ID: <20041109030555.GA2973@holomorphy.com>
References: <418F4F97.5000805@gmx.at> <1099915498.3577.7.camel@laptop.fenrus.org> <418F661E.6050601@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418F661E.6050601@gmx.at>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven schrieb:
>> eh isn't this already possible with mmap and mremap ?

On Mon, Nov 08, 2004 at 01:27:10PM +0100, Willibald Krenn wrote:
> If I'm not mistaken: You can not tell mmap and mremap to explicitely 
> exchange two pages. (Mremap resizes an existing memory mapping.)
> Perhaps I did not explain my idea good enough: I want something along 
> the lines "Current memory contents in page starting at address X move to 
> address Y and the contents of the page starting at address Y shall be 
> found at address X in future".

You're thinking of POSIX mremap(2); Linux' actual mremap() ABI allows
relocation of pages within a process address space, though only to
previously unoccupied locations, not direct exchange.


-- wli
