Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSEPKtI>; Thu, 16 May 2002 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSEPKtH>; Thu, 16 May 2002 06:49:07 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:14481 "EHLO
	albatross.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S311884AbSEPKtG>; Thu, 16 May 2002 06:49:06 -0400
Message-ID: <3CE38E9D.986ACF7F@uab.ericsson.se>
Date: Thu, 16 May 2002 12:49:01 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: <3CE250A5.47F71DF@uab.ericsson.se> <15586.20989.992591.474108@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Wednesday May 15, Sverker.Wiberg@uab.ericsson.se wrote:
> >
> > Hello everyone,
> >
> > When copying lots of small files from multiple NFS clients to a kNFSd
> > filesystem (i.e. doing backup of a cluster), exported with `sync', I
> > find that some few files (1 out of 1000) were silently truncated to zero
                                                  ^^^^^^^^
                                                  no errors reported 

> > size when checking locally with `ls' (the clients reported total
> > success). With `asynch' instead, all files were correctly copied.
> 
> How are you mounting the file systems on the clients?
> The symptoms sound exactly like you are using "soft" mounts.  "soft"
> is a very bad mount option.  Use "hard".
>
> If you aren't using "soft", let me know and I will look harder.

Errrm, I am using "soft" mounts, as I (we) want the clients to survive
server restarts.
But shouldn't those timeouts become errors over at the clients?

/Sverker
