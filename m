Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRLIAmp>; Sat, 8 Dec 2001 19:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277228AbRLIAme>; Sat, 8 Dec 2001 19:42:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277380AbRLIAmU>; Sat, 8 Dec 2001 19:42:20 -0500
Message-ID: <3C12B354.3060801@zytor.com>
Date: Sat, 08 Dec 2001 16:41:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Typedefs / gcc / HIGHMEM
In-Reply-To: <200112090039.BAA25399@webserver.ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

>>                                                                    
>>Why should there be?  The u32 value gets promoted to u64 before the 
>>comparison is done.                                                 
>>
>                                                                       
> Yes, ok, you're right. This was not a well thought out statement.     
> Anyway the problem with printf statement stays. It is obviously       
> confused by a unsigned long long and "%08x". How would you fix this?  
> Downcasting to u32?                                                   
> 


Either that or change it to %016llx or something like that.

>                                                                       
> Ha, I always wondered what this u64 is all about :-)                  
> Honestly, this whole datatyping is gone completely mad since the 16-32
> bit  change. In my opinion                                            
> byte is 8 bit                                                         
> short is 16 bit                                                       
> long is 32 bit                                                        
> <callwhatyouwant> is 64 bit (I propose long2 for expression of bitsize
> long * 2).                                                            
> <callwhatyouwant2> is 128 bit (Ha, right I would call it long4)       
>     


Well, you're wrong.

                                                                      
> How do you call a 64 bit datatype in a 128 bit environment? According 
> to your / the worlds current terminology long will then be 128 bit and
> int will (ridiculously) still be 32 bit. It will be pretty interesting
> to hear people talking about integer registers and people writing     
> portable applications do #define int long ... A wait this will break  
> your #typedef unsigned int u32 story :-)                              


int64_t.  See the C99 standard.

	-hpa

