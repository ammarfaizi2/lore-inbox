Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281972AbRKUUg7>; Wed, 21 Nov 2001 15:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281973AbRKUUgt>; Wed, 21 Nov 2001 15:36:49 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:32494 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281972AbRKUUge>; Wed, 21 Nov 2001 15:36:34 -0500
Message-ID: <3BFC1051.1050201@redhat.com>
Date: Wed, 21 Nov 2001 15:36:33 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Merkey <jmerkey@timpanogas.org>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs> <20011121191607.A32418@fenrus.demon.nl> <002801c172c6$3e23a8e0$f5976dcf@nwfs>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Merkey wrote:

>>Have you even looked at the kernel-source RPM ?
>>
> 
> Yes.  I based a Linux distribution on RedHat's 6.2 last year, and I am
> **VERY** familiar with your anaconda installer and kernel.src.rpm build
> modules.  I know the 7.X stuff got a hell of a lot better, but customers
> still have to sterilize the build area are your rpm gets installed in order
> to build external kernel modules.


<sigh>  Again, this isn't true.  I build modules against our 
kernel-source RPM tree all the time, and I *never* do a make distclean. 
  If I did, it would screw the tree permanently.  If you are basing your 
arguments about what you saw with 6.2, then you are sorely out of date 
(hell, that was still a 2.2 kernel system).  Things have improved a lot 
since then.  The one overridding rule of working with a tree like we 
ship though, is *NEVER* do anything in the tree itself.  That tree is 
assembled to provide *ALL* the kernel versions and includes for all the 
kernels we ship.  However, even doing a make dep in the tree will blow 
important parts away.  Download my module build kit and see what I'm 
talking about because you currently obviously *don't* know what I'm 
talking about.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

