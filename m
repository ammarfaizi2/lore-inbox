Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbTC0RkX>; Thu, 27 Mar 2003 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbTC0RkX>; Thu, 27 Mar 2003 12:40:23 -0500
Received: from port-212-202-184-205.reverse.qdsl-home.de ([212.202.184.205]:43194
	"EHLO el-zoido.localnet") by vger.kernel.org with ESMTP
	id <S263335AbTC0RkW>; Thu, 27 Mar 2003 12:40:22 -0500
Message-ID: <3E833A24.8060606@trash.net>
Date: Thu, 27 Mar 2003 18:51:32 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Chris Sykes <chris@sigsegv.plus.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk> <20030326193437.GI24689@kroah.com> <20030327111600.GI2695@spackhandychoptubes.co.uk> <20030327131214.1dae4005.skraw@ithnet.com> <3E82F00F.7@trash.net> <20030327174503.GB32667@kroah.com>
In-Reply-To: <20030327174503.GB32667@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Mar 27, 2003 at 01:35:27PM +0100, Patrick McHardy wrote:
>  
>
>>diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
>>--- a/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
>>+++ b/drivers/isdn/isdn_net.c	Thu Mar 27 02:00:21 2003
>>@@ -2831,6 +2831,7 @@
>> 
>> 			/* If binding is exclusive, try to grab the channel */
>> 			save_flags(flags);
>>+			cli();
>> 			if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
>> 				lp->l2_proto, lp->l3_proto, drvidx,
>> 				chidx, lp->msn)) < 0) {
>>    
>>
>
>I thought that cli() was being removed from the kernel, not added :)
>
>This can not build on SMP, so you might want to change it.
>  
>

this patch is for 2.4, isdn_get_free_channel is protected by cli() 
everywhere.

Patrick


