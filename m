Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUD2Sck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUD2Sck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUD2Sck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:32:40 -0400
Received: from mail.fastclick.com ([205.180.85.17]:59334 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264911AbUD2Sch
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:32:37 -0400
Message-ID: <40914A35.4010107@fastclick.com>
Date: Thu, 29 Apr 2004 11:32:21 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <200404291351.i3TDpoev003956@eeyore.valparaiso.cl>
In-Reply-To: <200404291351.i3TDpoev003956@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> "Brett E." <brettspamacct@fastclick.com> said:
> 
> [...]
> 
> 
>>I created a hack which allocates memory causing cache to go down, then 
>>exits, freeing up the malloc'ed memory. This brings free memory up by 
>>400 megs and brings the cache down to close to 0, of course the cache 
>>grows right afterwards. It would be nice to cap the cache datastructures 
>>in the kernel but I've been posting about this since September to no 
>>avail so my expectations are pretty low.
> 
> 
> Because it is complete nonsense. Keeping stuff around in RAM in case it
> is needed again, as long as RAM is not needed for anything else, is a mayor
> win. That is what cache is.
The key phrase in your post is "as long as RAM is not needed for 
anything else." My assertion was that this is not the case and it seems 
to favor cache over pages being used.  Sar shows heavy paging to/from 
disk even though 500 megs are reported in cache. I hope I don't need to 
go into what paging in/out in succession means regarding paging out 
pages which we will need shortly after they are paged out. Sar also 
reports no swapping, hence the need to figure out why there is a 
disprepency before continuing.


