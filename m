Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBPPoi>; Fri, 16 Feb 2001 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbRBPPo2>; Fri, 16 Feb 2001 10:44:28 -0500
Received: from ns.suse.de ([213.95.15.193]:25875 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129027AbRBPPoU>;
	Fri, 16 Feb 2001 10:44:20 -0500
To: aprasad@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: query about sending udp packets in kernel mode
In-Reply-To: <CA2569F5.0045056E.00@d73mta05.au.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 16 Feb 2001 16:44:17 +0100
In-Reply-To: aprasad@in.ibm.com's message of "16 Feb 2001 13:35:17 +0100"
Message-ID: <oup1ysytyy6.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aprasad@in.ibm.com writes:

> i am getting EFAULT.

Use

mm_segment_t oldseg = get_fs();
set_fs(KERNEL_DS);

... sendmsg

set_fs(oldseg); 


-Andi

P.S.: This is really getting a FAQ. If it isn't already please someone add 
it to the linux-kernel FAQ.

