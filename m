Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSBSSmb>; Tue, 19 Feb 2002 13:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSBSSmW>; Tue, 19 Feb 2002 13:42:22 -0500
Received: from cwbone.bsi.com.br ([200.194.240.1]:60773 "EHLO
	cwbone.bsi.com.br") by vger.kernel.org with ESMTP
	id <S286825AbSBSSmH>; Tue, 19 Feb 2002 13:42:07 -0500
Message-ID: <3C729C4C.7060903@escriba.com.br>
Date: Tue, 19 Feb 2002 15:41:16 -0300
From: "Alexandre P. Nunes" <alexnunes@escriba.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: blesson paul <blessonpaul@msn.com>, linux-kernel@vger.kernel.org
Subject: Re: loading modules
In-Reply-To: <F15LuSbh29cM3oryKFR00012514@hotmail.com>
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blesson paul wrote:

> Hi all
> I am a newbie to Kernel world. When I looked into the file system 
> files, I found that the initialization function ( where the file 
> system is registered) is "init_filesystem" where filesystem can be 
> coda, vfat etc. As far as know, the initialization function is
> int init_module(void)
> Then how kernel takes different initialization functions. I want to 
> know whether my know how is wrong or not


you have something like (function parameters supressed for simplifcation):

/* Kernel calls this in your module */
init_module()
{

do_something();
init_filesystem(...);

return whatever;
}


So the entry point for every kind of module, including filesystem 
modules, is init_module(), you don't implement init_filesystem in the 
module, you call it to let the kernel know you want to register a 
filesystem.

>
> Thanking in advance
> regards
> Blesson Paul


Cheers,

Alex

