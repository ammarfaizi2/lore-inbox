Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUAGLAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUAGLAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:00:38 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:5066 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265468AbUAGLAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:00:36 -0500
Message-ID: <3FFBE6D3.7090701@namesys.com>
Date: Wed, 07 Jan 2004 14:00:35 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: linux-kernel@vger.kernel.org, mfedyk@matchmail.com,
       Jesper Juhl <juhl-lkml@dif.dk>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       grev@namesys.com
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru> <3FFB46B0.9060101@namesys.com> <20040106235335.GC415627@linuxhacker.ru> <3FFBD0B1.50909@namesys.com> <20040107100113.GE415627@linuxhacker.ru>
In-Reply-To: <20040107100113.GE415627@linuxhacker.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Wed, Jan 07, 2004 at 12:26:09PM +0300, Hans Reiser wrote:
>  
>
>>>As for why gcc is finding this, but scripts (e.g. smatch) do not is because
>>>scripts generally know nothing about variable types, so they cannot tell
>>>this comparison was always false (and since gcc can do this for long time
>>>already, there is no point in implementing it in scripts anyway).
>>>      
>>>
>>can we get gcc to issue us a warning?  there might be other stuff 
>>lurking around also....
>>    
>>
>
>If you add -W switch to CFLAGS, you'd get A LOT of more warnings.
>Also just reading manpage on gcc around description of that flag will
>give you a list of options to individually turn on certain check types.
>Also gcc 3.3 have this sort of " unsigned < 0 | unsigned > 0" checks on by
>default, I think.
>
>Bye,
>    Oleg
>
>
>  
>
Sigh, this means that not one member of our team bothered to compile 
with -W and cleanup things that were found?  Sad.  This is what happens 
when project leaders like me spend more of their time on funding 
proposals than code tweaking.....

Elena, please do so, for both V3 and V4, and send a proposed patch to 
cleanup what gets complained of.

-- 
Hans


