Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281735AbRKVUhL>; Thu, 22 Nov 2001 15:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281738AbRKVUhB>; Thu, 22 Nov 2001 15:37:01 -0500
Received: from relais.videotron.ca ([24.201.245.36]:3051 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S281735AbRKVUgu>; Thu, 22 Nov 2001 15:36:50 -0500
To: Vincent Sweeney <v.sweeney@dexterus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <01112112401703.01961@nemo> <3BFB9FAE.DB9B6003@dexterus.com>
Mail-Copies-To: nobody
From: Chris Gray <cgray4@cs.mcgill.ca>
Date: 22 Nov 2001 15:43:15 -0500
In-Reply-To: <3BFB9FAE.DB9B6003@dexterus.com>
Message-ID: <87y9ky35b0.fsf@cs.mcgill.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Vincent Sweeney wrote:
>> 
>> drivers/block/paride/pf.c:      if (l==0x20) j--; targ[j]=0;
>> drivers/block/paride/pg.c:      if (l==0x20) j--; targ[j]=0;
>> drivers/block/paride/pt.c:      if (l==0x20) j--; targ[j]=0;
>>     (these files need Lindenting too)
>> ----------
>> Missing {} Either a bug or a very bad style (so bad that I can even
>> imagine that it is NOT a bug). Please double check before applying
>> the patch!  -- vda
> 
> C std says IFF you have one expression after the for() then you can
> omit the {}'s. So this is NOT a bug or bad coding style its just
> saving some bytes in the source code :)

The point here is that what is written as 

if(l==0x20) j--; targ[j]=0;

is actually

if(l==0x20)
        j--;
targ[j]=0;

and not the 

if(l==0x20){
        j--;
        targ[j] = 0;
}

that it appears to be.  I wouldn't like to use 'l' as a variable
either, but that's just me.

Cheers,
Chris
