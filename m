Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSKSTLa>; Tue, 19 Nov 2002 14:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbSKSTLa>; Tue, 19 Nov 2002 14:11:30 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:11657 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267146AbSKSTL3>;
	Tue, 19 Nov 2002 14:11:29 -0500
Message-ID: <3DDA8E81.4070508@colorfullife.com>
Date: Tue, 19 Nov 2002 20:18:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Akira Tsukamoto <at541@columbia.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance improvement with Akira Tsukamoto's Athlon copy_user
 patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I read the code of laze FPU state saving and confirmed that 
>if the function does not generate exception than
>'kernel_fpu_begin/end()' should assure fpu safe inside kernel.
>
>However, it is not enough where exception could rise, as Takahashi
>mentioned.


I had prototyped an exception safe kfpu framework, but then I didn't have the time to submit/cleanup it.

http://www.colorfullife.com/~manfred/linux-2.5/sse/patch-kfpu

Have you tried SSE based copy_to_user? With SSE, you can just save the affected registers, without unexpected sideeffects.

--
	Manfred


