Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSIIAIf>; Sun, 8 Sep 2002 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSIIAIf>; Sun, 8 Sep 2002 20:08:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:61618 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315634AbSIIAIe> convert rfc822-to-8bit;
	Sun, 8 Sep 2002 20:08:34 -0400
From: Daniel Mehrmann <daniel.mehrmann@gmx.de>
Organization: private
To: Dave Jones <davej@suse.de>
Subject: Re: [PATCH 2.4/2.5] Athlon CFLAGS
Date: Mon, 9 Sep 2002 02:13:10 +0200
User-Agent: KMail/1.4.6
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <200209082128.11316.daniel.mehrmann@gmx.de> <20020909011833.B14358@suse.de>
In-Reply-To: <20020909011833.B14358@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209090213.10063.daniel.mehrmann@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 01:18, Dave Jones wrote:
> On Sun, Sep 08, 2002 at 09:28:11PM +0200, Daniel Mehrmann wrote:
>  > Hi Alan,
>  >
>  > i add for the AMD Athlon family some optimize compilerflags.
>  > Gcc 3.1 and 3.2 support more specific Athlon instructions as
>  > 3.0 or 2.95x. This patch for 2.4.19, 2.4.20-pre5 and 2.5.33
>  > set a new "-march" flag:
>  >
>  > Athlon TB/Duron 		+= -march=athlon-tbird
>  > Athlon XP/Athlon4/Duron	+= -march=athlon-xp
>  > Athlon MP				+= -march=athlon-mp
>
> I thought these were all just gcc aliases for the same options ?
> It's been a while since I looked at the gcc option parser, so
> I've forgotten exactly what happens, but at least you missed the
> bogus athlon-4 option.
>
> Are the gains between all these options really worth the added
> complexity ?
>
>         Dave

Hi Dave,

yes, you`re right with the athlon-4 option. Well, first thing, the mobile athlon
have the same core as XP (Palomino) expect some "speed scheudle". 
I never see that we support mobile chips. So i think it`s enough that we 
put Athlon4 into the "XP group". I think too the new core "Thoroughbread" 
should use the "XP group". 

I readed the gcc documentation, gcc-3.2 only, very deep. This was the idea for this patch.
Then i looked fast into gcc-3.1/3.0/2.95x. I believe that the compiler create own code 
for *every* chip-release. chip-release as: athlon-tbird, athlon-xp, ...

Also take a look into the binary code and size. It`s different. 

chears,
Daniel

   





 

