Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319190AbSIDPo7>; Wed, 4 Sep 2002 11:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319191AbSIDPo7>; Wed, 4 Sep 2002 11:44:59 -0400
Received: from unix.tamu.edu ([128.194.103.25]:12688 "EHLO fox.tamu.edu")
	by vger.kernel.org with ESMTP id <S319190AbSIDPod>;
	Wed, 4 Sep 2002 11:44:33 -0400
Date: Wed, 4 Sep 2002 10:49:07 -0500 (CDT)
From: Vikas Jain <v0j1217@unix.tamu.edu>
To: linux-kernel@vger.kernel.org
Subject: Joystick driver development
In-Reply-To: <Pine.SOL.3.96.1020904003605.12242A-100000@scully.tamu.edu>
Message-ID: <Pine.SOL.3.96.1020904104855.26370B-100000@fox.tamu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Howdy,
> 
> I am trying to write a new kernel mode joystick driver for linux. I tested
> my logic by first making a user mode driver and testing it.
> 
> The problem I am facing is in communication with joystick from the kernel
> space.
> 
> 
> I use  request region to gain acces to joystick port from kernel mode, as
> follows:
> 
> 
>         if(request_region(BASEPORT,1,"Joystick")!=NULL)
>         {
>                 printk("\nPort avilable");
>                 printk("\nyou read %d",inb(BASEPORT));
>         }
> 
> Then i use outb and inb functions to access port, and send back the
> joystick reading to the user application.
> 
> 
> The problem is sometimes the joystick read doesnt drop from 255, and thus
> I get no change in input values.
> 
> I examined existing joystick driver code , and Mr.Pavlik  do not use this
> approach. Can you tell mewhere I am wrong?
> 
> Thanks,
> Vikas
> Texas A&M
> 
> 
> 

