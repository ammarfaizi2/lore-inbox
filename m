Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSHMR5i>; Tue, 13 Aug 2002 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319045AbSHMR47>; Tue, 13 Aug 2002 13:56:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49420 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319026AbSHMRzy>; Tue, 13 Aug 2002 13:55:54 -0400
Message-ID: <3D594901.9070305@zytor.com>
Date: Tue, 13 Aug 2002 10:59:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
References: <3D58B14A.5080500@zytor.com> <ajaka7$qb6$1@ncc1701.cistron.net> <ajbgbf$7e7$1@cesium.transmeta.com> <20020813135405.A12730@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Aug 13, 2002 at 10:41:03AM -0700, H. Peter Anvin wrote:
> 
>>Requires too much to work before it's can be made available.
>>
>>Andrew Morton sent me a proposed patch last night which adds a klogctl
>>(a.k.a. sys_syslog) which does a printk() from userspace.  It was less
>>than 10 lines; i.e. probably worth it.  I have hooked this up to
>>syslog(3) in klibc, although the code is not checked in yet.
> 
> 
> Rather, why not have the file descriptor early userspace gets called 
> with point to a file that printk's whatever is written to it?  That 
> makes more sense as the early init stuff really should end up in the 
> kernel's log buffer.
> 

That was the other possibility that I suggested... either way is fine 
with me.  The file descriptor has a few advantages; although I would 
personally make a klogctl() to return it rather than having it passed in.

	-hpa


