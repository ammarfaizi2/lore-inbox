Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315321AbSDWUGB>; Tue, 23 Apr 2002 16:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315323AbSDWUGA>; Tue, 23 Apr 2002 16:06:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315321AbSDWUF7>; Tue, 23 Apr 2002 16:05:59 -0400
Message-ID: <3CC5BEA2.7050507@zytor.com>
Date: Tue, 23 Apr 2002 13:05:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@suse.de>, Brian Gerst <bgerst@didntduck.org>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <Pine.LNX.4.44.0204231218540.19326-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> 
>>I mean, if they change the registers layout, and so if they require a
>>different empty FPU state, they must as well add yet another bitflag to
>>enable SSE3, if they don't the chip isn't backwards compatible.
> 
> 
> I have unofficial confirmation from Intel that the way to architecturally
> initialize the FPU state is indeed something like
> 
>         memset(&fxsave, 0, sizeof(struct i387_fxsave_struct));
>         fxsave.cwd = 0x37f;
>         fxsave.mxcsr = 0x1f80;
>         fxrstor(&fxsave);
> 
> and the person in question is trying to make sure this is documented so
> that we won't be bitten by this in the future.
> 

Great!

	-hpa


