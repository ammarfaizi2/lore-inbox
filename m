Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSEVLni>; Wed, 22 May 2002 07:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSEVLnh>; Wed, 22 May 2002 07:43:37 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34565 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311871AbSEVLng>; Wed, 22 May 2002 07:43:36 -0400
Message-ID: <3CEB758B.2080304@evision-ventures.com>
Date: Wed, 22 May 2002 12:40:11 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB5F75.4000009@evision-ventures.com> <15595.30247.263661.42035@argo.ozlabs.ibm.com> <20020522.035435.68675894.davem@redhat.com> <3CEB6F31.2000301@evision-ventures.com> <20020522122617.B16934@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Wed, May 22, 2002 at 12:13:05PM +0200, Martin Dalecki wrote:
> 
>>And now I'm just eagerly awaiting the first clueless
>>l^Huser lurking on this list, who will flame me as usuall...
>>But that's no problem - I got already used to it :-).
> 
> 
> I'm waiting on Phil Blundell to notice - I think /dev/port may get used
> on ARM to emulate inb() and outb() from userspace; I don't look after
> glibc so shrug.
> 
> I agree however that /dev/port is a rotten interface that needs to go.
> 

Hmm still not flames? Do they all sleep right now?

- Should I perhaps tell what I think about the glibc bloat^W coding style?

- Should I perhaps tell how "usefull" the GNU extensions to the POSIX
   standards in question are?

- Or a side note about RH's slang and popt and other useless "required"
   shared libraries?

- Is there maybe some Python module using /dev/port for precisely
   the purpose you mention. (This is actually a good candidate.)

Anyway, dear Russell (plese note the double ll!):

[root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep \/dev\/port 
/dev/null {} \;
[root@kozaczek glibc-2.2.5]#

[root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep \"port\" 
/dev/null {} \;
./hesiod/nss_hesiod/hesiod-service.c:  return lookup (portstr, "port", protocol, 
serv, buffer, buflen, errnop);
[root@kozaczek glibc-2.2.5]#
[root@kozaczek glibc-2.2.5]# find ./ -name "*.[ch]" -exec grep outb\( /dev/null 
{} \;
[root@kozaczek glibc-2.2.5]#

So I rather think that glibc may be bloated but it's not idiotic and
we have nothing to fear from it ;-)... well this time at least...
As far as I know (and I know little about ARM). It would be anwyay
unnatural to use /dev/port for the purpose you mention.
ARM io space is memmory mapped, so if any file you would
rather use /dev/kmem...

Still no flames? This silence makes me suspicious....

