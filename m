Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUC3PyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUC3PyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:54:09 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:29574 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261816AbUC3PyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:54:07 -0500
Message-ID: <406997E3.60005@nortelnetworks.com>
Date: Tue, 30 Mar 2004 10:53:07 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com>
In-Reply-To: <20040329235233.GV791@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Mon, Mar 29, 2004 at 03:06:16PM -0800, Matthew Dobson wrote:
>>If we're
>>not assuming the unused bits are 0's, then we need to do this last word
>>special casing in bitmap_xor & bitmap_andnot, because they could set the
>>unused bits.  Or am I confused?
> 
> 
> No, not those two. xor of 0's is 0 again. and of 0 and anything is 0 again.

Huh?  Xor of 0 and 1 is 1.

Chris
