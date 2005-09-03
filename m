Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbVICFxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbVICFxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbVICFxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:53:25 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:53138 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1161147AbVICFxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:53:24 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <43193A4F.5030906@zytor.com>
Date: Fri, 02 Sep 2005 22:53:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com> <20050903055007.GA30966@codepoet.org>
In-Reply-To: <20050903055007.GA30966@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Fri Sep 02, 2005 at 10:22:20PM -0700, H. Peter Anvin wrote:
> 
>>Exportable types need to be double-underscore types, because the header 
>>files in user space that would include them can generally not include 
>><stdint.h>.
> 
> 
> I'm not talking about kernel headers that have to worry about
> eventually being included in user space headers.  Those nearly
> all live in include/asm.  I'm talking about the kernel headers
> that define how userspace is supposed to interface with
> particular kernel drivers or hardware.  Headers such as
> linux/cdrom.h and linux/loop.h and linux/fb.h.
> 

What are you going to do with them if you're not going to include them 
in userspace?!!!

If you're proposing one policy for linux/loop.h and one for sys/stat.h, 
I would have to classify that as insane.  Everything that gets exported 
to userspace should behave the same way, please.

	-hpa
