Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSGVMSJ>; Mon, 22 Jul 2002 08:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGVMSJ>; Mon, 22 Jul 2002 08:18:09 -0400
Received: from www.wotug.org ([194.106.52.201]:42590 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S315437AbSGVMSJ>; Mon, 22 Jul 2002 08:18:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
To: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.17 /dev/ports
Date: Mon, 22 Jul 2002 13:20:39 +0100
User-Agent: KMail/1.4.2
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       "David S. Miller" <davem@redhat.com>, paulus@samba.org,
       linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0205221109240.2737-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0205221109240.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207221320.39382.ruthc@sharra.ivimey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 May 2002 16:10, Alexander Viro wrote:
> On Wed, 22 May 2002, Alan Cox wrote:
> > > ... and while we are at flamewar-mongering, none of these files have
> > > any business being in procfs.
> >
> > That depends on how you define procfs. Linux is not Plan 9. A lot of it
> > certainly is going to cleaner with a devicefs and sysctlfs
>
> OK, let me put it that way:
>
> none of these files has any business bringing the rest of procfs along
> for a ride and none of them has any reason to use any code from fs/proc/*.c

Ok, I'll bite. Why? Note: I'm not necessarily saying I disagree, just that I 
don't know what "test" you are applying to determine whether stuf should be 
in or out?

Personally, my test is "does it provide useful information to a program or to 
a user that is not available in other ways, or where the other ways require 
an ioctl interface". 

I insert the second phrase because I do like the general principle that in 
Unix you read and write stuff to files, and procfs does provide a lot of 
extra scope for that to happen.

There is an obvious problem with formats, but that is a specification and 
discipline issue between the various developers, and not something that is 
wrong with procfs as such.

Ruth
