Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284996AbRLQEDh>; Sun, 16 Dec 2001 23:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284998AbRLQED2>; Sun, 16 Dec 2001 23:03:28 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:8711 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284996AbRLQEDK>; Sun, 16 Dec 2001 23:03:10 -0500
Subject: Re: Alpha  - how to fill the PC
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: Tyler BIRD <birdty@uvsc.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <sc1c97f4.073@mail-smtp.uvsc.edu>
In-Reply-To: <sc1c97f4.073@mail-smtp.uvsc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 09:33:34 +0530
Message-Id: <1008561818.20446.0.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No, I have the full address space rebuilt on node2. I validated it
checking /proc/<pid>/maps 

-aneesh  

 


On Mon, 2001-12-17 at 01:17, Tyler BIRD wrote:
> One thing I thought of is the process on lets say node2 have exactly the same
> address space as on node 1 when it is migrated.  You could be trying to return from a syscall
> to an address space of a process that doesn't exist on the node or hasn't migrated yet.
> 
> Just a thought
> 
> >>> "Aneesh Kumar K.V" <aneesh.kumar@digital.com> 12/16/01 06:19AM >>>
> Hi, 
> 
>  	I am trying to do  process migration between nodes  using alpha
> architecture. For explaining what is happening I will take the process
> getting migrated from node1 to node2. I am using struct pt_regs  for
> rebuilding the process on  node2.I am getting the same  value of struct
> pt_regs on node1 and on node2 ( I print is using dik_show_regs) Now I
> want to set the value of registers including the program counter with
> the value i got from node1. Right now I am doing
> ret_from_sys_call(&regs). But then i am getting a Oops . The Oops
> message contain all the register values same as that I got from node1
> except pc and ra 
> 
> 	Any idea where I went wrong ? 
> 
>  -aneesh 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at  http://www.tux.org/lkml/


