Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVA0CBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVA0CBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVAZXqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:46:25 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:57799 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262034AbVAZTNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:13:37 -0500
Message-ID: <41F7EBC7.5030108@nortelnetworks.com>
Date: Wed, 26 Jan 2005 13:13:11 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Bryn Reeves <breeves@redhat.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Antill <james.antill@redhat.com>
Subject: Re: don't let mmap allocate down to zero
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>  <Pine.LNX.4.61.0501261130130.17993@chaos.analogic.com>  <41F7D4B0.7070401@nortelnetworks.com> <1106762261.10384.30.camel@breeves.surrey.redhat.com> <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0501261325540.18301@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

> The seg-fault you get when you de-reference a pointer to NULL
> is caused by the kernel. You are attempting to access memory
> that has not been mapped into your address space. Once that
> memory gets mmap()ed, you will no longer get a seg-fault.
> Again, the seg-fault has nothing to do with 'C'. It's an
> implementation behavior that can be changed with mmap().

The segfault *does* have something to do with C.  The standard says that 
the result of dereferencing a NULL pointer is *undefined*.  Not 
implementation-defined, but undefined.  Anything relying on 
dereferencing NULL pointers is not valid C code.

Chris
