Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVA0C4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVA0C4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVAZXRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:17:04 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34733 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262450AbVAZRfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:35:17 -0500
Message-ID: <41F7D4B0.7070401@nortelnetworks.com>
Date: Wed, 26 Jan 2005 11:34:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com> <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> Does this mean that we can't mmap the screen regen buffer at
> 0x000b8000 anymore?
> 
> How do I look at the real-mode interrupt table starting at
> offset 0? You know that the return value of mmap is to be
> checked for MAP_FAILED, not for NULL, don't you?

Can't you still map those physical addresses to other virtual addresses?

> What 'C' standard do you refer to? Seg-faults on null pointers
> have nothing to do with the 'C' standard and everything to
> do with the platform.

I believe the ISO/IEC 9899:1999 C Standard explicitly states that 
dereferencing a null pointer with the unary * operator results in 
undefined behavior.

Chris
