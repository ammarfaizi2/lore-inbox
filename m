Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWDNS7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWDNS7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDNS7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:59:48 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:10659 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbWDNS7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:59:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OF6QPlG2TClbcBC29+VMHVY0z9a31QWsiXFYMHm5iwKHMDHQi0T9/8JuUVEncl1bnKKkZJqsncWtA+Pa6aA8NTn/JpA8Au5BnDlK+vUPEzV1h+yIV7UbWM5vP7E9p8hjg1WHazoTU+ZFI/AEB0NraejcymPwutmZAChZ/EwlNkI=
Message-ID: <443FF181.6000004@gmail.com>
Date: Fri, 14 Apr 2006 22:01:21 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <443EE4C3.5040409@gmail.com> <443FE1AF.8050507@zytor.com> <443FE560.6010805@gmail.com> <443FEDF9.6050203@zytor.com>
In-Reply-To: <443FEDF9.6050203@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> 
> Well, obviously, since apparently LILO doesn't properly null-terminate 
> long command line.
> 
> Thinking about it a bit, the way to deal with the LILO problem is 
> probably to actually *usw* the boot loader ID byte we've had in there 
> since the 2.00 protocol.  In other words, if the boot loader ID is 0x1X 
> where X <= current version (I don't know how LILO manages this ID) then 
> truncate the command line to 255 bytes; when this is fixed in LILO then 
> LILO gets to bump its boot loader ID version number.
> 
>     -hpa

I don't understand...

If LILO worked until now, it should continue to work after 
applying this patch, since nothing was changed from its 
perspective. It will continue to provide 255 characters + 
null command line, so even if you have 1024 max 
command-line, then you will still receive truncated to 255 
chars.

What I think is that the boot.txt should be clearer... But 
if you think that this patch can be applied without making 
any change to the documentation that's will also be great! I 
will try to deal with boot loaders developers afterwards...

Best Regards,
Alon Bar-Lev.
