Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136282AbRECJS0>; Thu, 3 May 2001 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136290AbRECJSR>; Thu, 3 May 2001 05:18:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:42501 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136282AbRECJSI>; Thu, 3 May 2001 05:18:08 -0400
Subject: Re: memory and current macro
To: peterius@durandal.simons-rock.edu
Date: Thu, 3 May 2001 10:21:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p04320402b7166eda68f2@[64.210.111.70]> from "peterius@mail.simons-rock.edu" at May 02, 2001 10:20:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFIr-0005EC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> problems.  First, the current macro.  I wanted to get the uid of the 
> calling process but "current->uid" does NOT work it returns some 
> other number.  Same with "current->pid" and many others.  I figured 
> these numbers weren't random and decided to print out a particular 
> processes's descriptor and check out what was going on.  I found that 
> "&(current->uid)" is 0x1d lower than the address that holds the user 
> id.  In addition, adding 0x1d to that address added it twice???  So 
> to get the uid I ended up adding half...or "&(current->uid) + 0x0f". 
> Does anyone know why this is?  I have an i686 processor, IBM thinkpad 

You are compiling with headers that dont match the kernel you are running
or with options not matching. You should be using module versioning if possible
btw on both the kernel and the module that would catch most such slips

