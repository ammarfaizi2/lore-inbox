Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTJNBw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 21:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTJNBw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 21:52:59 -0400
Received: from dyn-ctb-210-9-245-201.webone.com.au ([210.9.245.201]:20741 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262133AbTJNBw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 21:52:58 -0400
Message-ID: <3F8B56E4.1060902@cyberone.com.au>
Date: Tue, 14 Oct 2003 11:52:36 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Darren Williams <dsw@gelato.unsw.edu.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM code question
References: <20031014013227.GA20406@cse.unsw.EDU.AU> <20031014014427.GL16158@holomorphy.com>
In-Reply-To: <20031014014427.GL16158@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

>On Tue, Oct 14, 2003 at 11:32:27AM +1000, Darren Williams wrote:
>
>>I have a small question wrt some VM code.
>>source file is include/linux/kernel.h
>>#define container_of(ptr, type, member) ({                      \
>>        const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
>>        (type *)( (char *)__mptr - offsetof(type,member) );})
>>what is the use of the 0 (zero) in the typeof? I am thinking
>>that we are casting 0 to (type *) then referencing 'member' of
>>'type', however why do we require the 0 ?
>>Just curious
>>
>
>It's an address calculation method. We subtract the address of the
>start of the structure from the address of the member inside the
>structure.
>

AFAIKS the 0 is not part of the address calculation method though. It
is only used in the argument to the typeof operator. I think 0 is used
simply because its as good a place as any, right?


