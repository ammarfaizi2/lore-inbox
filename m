Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135867AbREIGnH>; Wed, 9 May 2001 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135870AbREIGm6>; Wed, 9 May 2001 02:42:58 -0400
Received: from lilly.ping.de ([62.72.90.2]:65297 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S135867AbREIGmo>;
	Wed, 9 May 2001 02:42:44 -0400
Date: 9 May 2001 08:38:23 +0200
Message-ID: <20010509063824.1424.qmail@toyland.ping.de>
From: "Michael Stiller" <michael@toyland.ping.de>
To: "Chris Mason" <mason@suse.com>
Cc: "Michael Stiller" <michael@ping.de>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
X-Mailer: exmh version 2.0.2 2/24/98
Subject: Re: 2.2.19 + reiserfs 3.5.32 nfsd wait_on_buffer/down_failed 
In-Reply-To: Your message of "Tue, 08 May 2001 22:22:43 EDT."
             <1164860000.989374963@tiny> 
X-Url: http://www.ping.de/~michael
X-Face: "wBy`XBjk-b]Wks].wV-RmZmir({Qfv85d&!VDrjx+4Ra(/ZyXjaV-x^QXX-Ab5X#3Eap^/
  W^Zo.K9=py=t6/F&p3cl/.zrgKH)0uxy{#5Y(_dD=ftF*Q}-lp\&Z-563qR3X5qv^o9~iP(pw3_1q
  !ti@9"V[C?^iW\BVArF#(YjjLJ/[R%Ri*sw
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > we run a nfs server utilizing 2.2.19 + ReiserFS version 3.5.32 on a
> > P 3 550 machine. Disk subsystem is a GDT7518RN using 4 UW disks as raid 5
> > device. After upgrading from 2.2.17 + reiserfs to 2.2.19 we experience
> > many (very much more than with 2.2.17) problems with our nfs clients
> > about 12 (linux). Network ist 100Mbit full duplex / switched. 
> > I do not think this is network related, cause ping -f doesnt show any
> > packet loss. 
> > 
> > During not so heavy IO on the exported fs
> > one nfsd thread seems to be waiting for the disk:
> 
> Are you running any patches to make knfsd deal with the reiserfs iget issues?

No. Just plain 2.2.19 + reiserfs 3.5.32. Should i use any patches ? 
I just checked ftp.suse.com/pub/people/mason/reiserfs/patches and 
there are only 2.2.19pre patches. 

Does it help to mount the filesystems noatime ?

Chris, do you have any idea where the problem may be located ? 

Cheers,

-Michael



-- 
x(f,s,c)char *s;{return f&1 ? *s ? *s-c ? x(f,++s,c) :7[s]:0:f&2 
? x(--f,"!/*,xq-ih9]c$=le&M t)r\nm@p31n%ag.8}Sdoy",c):f&4 ? *s ? 
x(f,s+1,putchar(x(f-2,"^&%!*)",*s))) : 0 : 0;}main(){return x(4,
"]!x/mhicn$!iihle&!x/mhiM$agimr%p !r@p%he&!x/mhiM !r@p%he",65);}


