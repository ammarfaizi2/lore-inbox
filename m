Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRKFBaq>; Mon, 5 Nov 2001 20:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRKFBag>; Mon, 5 Nov 2001 20:30:36 -0500
Received: from codepoet.org ([166.70.14.212]:45867 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S276914AbRKFBaa>;
	Mon, 5 Nov 2001 20:30:30 -0500
Date: Mon, 5 Nov 2001 18:30:32 -0700
From: Erik Andersen <andersen@codepoet.org>
To: David Dyck <dcd@tc.fluke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 doesn't compile: deactivate_page not defined in loop.c
Message-ID: <20011105183032.A17445@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Dyck <dcd@tc.fluke.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111051654140.4708-100000@dd.tc.fluke.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 05, 2001 at 04:57:18PM -0800, David Dyck wrote:
> 
> 
> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x8ad9): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8b19): undefined reference to `deactivate_page'
> 
> 
> a grep from deactivate_page only shows up in  linux/drivers/block/loop.c

It used to be in mm/swap.c but it no longer is....
Looks like the loop device needs some surgery,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
