Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVE0Sqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVE0Sqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVE0Sqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:46:51 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:58250 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S262504AbVE0Sqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:46:49 -0400
Message-ID: <42976B10.5030101@nortel.com>
Date: Fri, 27 May 2005 12:46:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cranium2003 <cranium2003@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel memory usage any restrictions?
References: <20050527181851.69524.qmail@web33008.mail.mud.yahoo.com>
In-Reply-To: <20050527181851.69524.qmail@web33008.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cranium2003 wrote:
> hello,
>               Is there any restricition on using
> kernel's memory? also if i require to use some kernel
> memory say 625kB by allocating that in GFP_ATOMIC mode

Your call will almost certainly fail.  I think kmalloc will only give 
you up to 128KB, and even that might be tricky to do with GFP_ATOMIC.

For larger chunks of memory, you can use vmalloc() or reserve it 
statically at compile time.

Chris
