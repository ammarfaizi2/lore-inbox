Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUIJGpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUIJGpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUIJGpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:45:35 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:27056 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263778AbUIJGpM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:45:12 -0400
Message-ID: <41414D73.5080902@free.fr>
Date: Fri, 10 Sep 2004 08:45:07 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       petkan@nucleusys.com
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com>
In-Reply-To: <20040909223605.GA17655@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Sep 09, 2004 at 03:24:54PM -0700, Andrew Morton wrote:
> 
>>Eric Valette <eric.valette@free.fr> wrote:
>>
>>>Here is a small patch that makes the card functionnal again. I've 
>>>forwarded the patch to driver author also.
>>>
>>>--- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
>>>+++ linux/drivers/usb/net/rtl8150.c	2004-09-09 11:15:46.000000000 +0200
>>>@@ -341,7 +341,7 @@
>>> 
>>> static int rtl8150_reset(rtl8150_t * dev)
>>> {
>>>-	u8 data = 0x11;
>>>+	u8 data = 0x10;
>>
>>hm, OK.  Presumably the change (which comes in via the bk-usb tree) was
>>made for a reason.  So I suspect both versions are wrong ;)
>>
>>But it might be risky for Greg to merge this patch up at present.
> 
> 
> As all your patch does is revert the patch in my tree (it was a one line
> change), mainline should work just fine for you, right?
> 
> I'll defer to Petkan as to what to do about this, as he sent me that
> patch for a good reason I imagine :)

FYI : I already forwarded the patch to the author. Just copied LKML so 
that other can get the fix easily.

NB : I just reverted one small change, the rest of the changes (mainly 
access to driver private data, and IOCTL ops) are OK...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



