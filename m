Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284879AbRLPWcG>; Sun, 16 Dec 2001 17:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284890AbRLPWb4>; Sun, 16 Dec 2001 17:31:56 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:34863 "HELO
	mail-smtp.uvsc.edu") by vger.kernel.org with SMTP
	id <S284879AbRLPWbo> convert rfc822-to-8bit; Sun, 16 Dec 2001 17:31:44 -0500
Message-Id: <sc1c97f4.074@mail-smtp.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Sun, 16 Dec 2001 12:47:37 -0700
From: "Tyler BIRD" <birdty@uvsc.edu>
To: <aneesh.kumar@digital.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Alpha  - how to fill the PC
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing I thought of is the process on lets say node2 have exactly the same
address space as on node 1 when it is migrated.  You could be trying to return from a syscall
to an address space of a process that doesn't exist on the node or hasn't migrated yet.

Just a thought

>>> "Aneesh Kumar K.V" <aneesh.kumar@digital.com> 12/16/01 06:19AM >>>
Hi, 

 	I am trying to do  process migration between nodes  using alpha
architecture. For explaining what is happening I will take the process
getting migrated from node1 to node2. I am using struct pt_regs  for
rebuilding the process on  node2.I am getting the same  value of struct
pt_regs on node1 and on node2 ( I print is using dik_show_regs) Now I
want to set the value of registers including the program counter with
the value i got from node1. Right now I am doing
ret_from_sys_call(&regs). But then i am getting a Oops . The Oops
message contain all the register values same as that I got from node1
except pc and ra 

	Any idea where I went wrong ? 

 -aneesh 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

