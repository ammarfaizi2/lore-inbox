Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317216AbSFBSon>; Sun, 2 Jun 2002 14:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317218AbSFBSom>; Sun, 2 Jun 2002 14:44:42 -0400
Received: from adsl-66-136-199-111.dsl.austtx.swbell.net ([66.136.199.111]:31619
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317216AbSFBSol>; Sun, 2 Jun 2002 14:44:41 -0400
Subject: Re: Very big shm area
From: Austin Gonyou <austin@digitalroadkill.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Kilobug <kilobug@freesurf.fr>, lkm <linux-kernel@vger.kernel.org>
In-Reply-To: <20020602183721.GG14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: http://www.digitalroadkill.net
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 Jun 2002 13:44:11 -0500
Message-Id: <1023043451.3021.8.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To get *good* performance from such a large SGA, it's best to use a -aa
kernel I've found. Either 2.4.18-aa + whatever patches, or something
similar. But there's been some fixes/changes/optimizations to the -aa
tree with regards to large memory boxes. 

I'm curious though how P4 HT will play into that performance on the new
Xeons though. I'll have more to report in the next few weeks.


On Sun, 2002-06-02 at 13:37, William Lee Irwin III wrote:
> On Sun, Jun 02, 2002 at 07:21:21PM +0200, Kilobug wrote:
> > Hello,
> > 	I wanted to know if it is possible to have a very big system V 
> > 	shared memory segment (say about 1Gb) ?
> > 	I've quickly looked into the source code of shm.c and shm.h in ipc/ 
> > 	and I've read the following:
> > /*
> >  * SHMMAX, SHMMNI and SHMALL are upper limits are defaults which can
> >  * be increased by sysctl
> >  */
> > But how far is it possible to increase them ? And which sysctl must be 
> > done ?
> > Thank you for answering,
> 
> ls /proc/sys/kernel/sh* and the names shouldn't be too tough from there.
> I'd be concerned about exercising this code on a virgin 2.4.17 as ISTR
> bugfixes for sysv ipc/shm cropping up in later kernel versions, though
> I can't say I've tracked this area very closely. Hopefully someone who
> does can chime in here and enlighten us both.
> 
> 
> Cheers,
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
