Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbTCJTtb>; Mon, 10 Mar 2003 14:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbTCJTtb>; Mon, 10 Mar 2003 14:49:31 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:18343 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261454AbTCJTt2>; Mon, 10 Mar 2003 14:49:28 -0500
Message-ID: <3E6CEEB9.1050304@nortelnetworks.com>
Date: Mon, 10 Mar 2003 14:59:53 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Move "used FPU status" into new non-atomic thread_info->status field.
References: <Pine.LNX.4.44.0303101119220.2240-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 10 Mar 2003, David S. Miller wrote:
> 
>>   
>>At least on sparc{32,64}, we consider FPU state to be clobbered coming
>>into system calls, this eliminates a lot of hair wrt. FPU state
>>restoring in cases such as fork().
>>
> 
> We could _probably_ do it on x86 too. The standard C calling convention on 
> x86 says FPU register state is clobbered, if I remember correctly. 
> However, some of the state is "long-term", like rounding modes, exception 
> masking etc, and even if we didn't save the register state we would have 
> to save that part.
> 
> And once you save that part, you're better off saving the registers too, 
> since it's all loaded and saved with the same fxsave/fxrestor instruction 
> (ie we'd actually have to do _more_ work to save only part of the FP 
> state).

Does this open the door for using FP in the kernel?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

