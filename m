Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUHSUj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUHSUj0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUHSUj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:39:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:12522 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267393AbUHSUjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:39:12 -0400
Message-ID: <4125100C.80703@austin.ibm.com>
Date: Thu, 19 Aug 2004 15:39:40 -0500
From: Olof Johansson <olof@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Alignment of bitmaps for ext2_set_bit et al.
References: <16676.35837.215958.814591@cargo.ozlabs.ibm.com> <20040819042234.75020cbc.akpm@osdl.org>
In-Reply-To: <20040819042234.75020cbc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Paul Mackerras <paulus@samba.org> wrote:
>  
>
>>Olof has made a patch that uses atomics for these on ppc64 rather than
>>locking and unlocking a lock, but it will only work correctly if the
>>bitmap is always 8-byte aligned.
>>    
>>
>
>Sounds sane, as long as you get firmly notified when a poorly-aligned
>address is fed in.
>  
>
The notification is in the form of an unalignment trap resulting in a 
panic, is that firm enough? :-)


-Olof
