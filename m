Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKZLfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKZLfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 06:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKZLfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 06:35:17 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:4897 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750829AbVKZLfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 06:35:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Cbdi073OtAsWnsXgFSD3n2pK1efnVGqmdzsvhMCVx3vAJf/NEqUcfmDKIyQqmXI2ftZWaqgmOCAqQxxEnSX/T7GQA2+9nUePtK2fm1TXFKhbXNamu8HTe2bCpvqxVZjRGdjzEfvcY41H3MDBUQltt4ZjhvoHmoFAW/pZk2vwRf8=
Message-ID: <43884848.9040301@gmail.com>
Date: Sat, 26 Nov 2005 19:34:32 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Vishal Soni <vishal.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to get SDA/SCL bit position in the control word register
 of the video card?
References: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>	<20051125203300.0899e9b7.khali@linux-fr.org>	<e3e24c6a0511252012v52a26698ua1d8b73eda2133fb@mail.gmail.com> <20051126113633.4f2fb35a.khali@linux-fr.org>
In-Reply-To: <20051126113633.4f2fb35a.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Vishal,
> 
>>>>> I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
>>>> then using kgdb to debug the kernel module (that i wrote) to get the
>>>> same  but failed to find the way to get the above.
>>> I couldn't find any function by that name in the Linux kernel source
>>> tree. What are you talking about?
>> /usr/src/linux-2.6.x/include/video/edid.h
> 
> There is no function by that name in that file, neither in Linus'
> latest kernel, nor in Andrew Morton's one. Whatever you are talking
> about does not seem to exist.
> 

That's the old name.  It's now renamed to fb_firmware_edid() which is in
drivers/video/fbmon.c. But you won't get anything from this function.
The DDC transfer was done entirely by the Video BIOS using a VBE interrupt
call during boot in arch/i386/boot/video.S:store_edid.

Tony 
 
