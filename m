Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRC2WjQ>; Thu, 29 Mar 2001 17:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRC2Wi4>; Thu, 29 Mar 2001 17:38:56 -0500
Received: from jalon.able.es ([212.97.163.2]:21447 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129321AbRC2Wit>;
	Thu, 29 Mar 2001 17:38:49 -0500
Date: Fri, 30 Mar 2001 00:38:01 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Jerry Hong <jhong001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how mmap() works?
Message-ID: <20010330003801.E1052@werewolf.able.es>
In-Reply-To: <20010329221451.27582.qmail@web4303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010329221451.27582.qmail@web4303.mail.yahoo.com>; from jhong001@yahoo.com on Fri, Mar 30, 2001 at 00:14:51 +0200
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.30 Jerry Hong wrote:
> Hi, 
>   mmap() creates a mmaped memory associated with a
> physical file. If a process updates the mmaped memory,
> Linux will updates the file "automatically". If this
> is the case, why do we need msync()? If this is not

Where did you heard that ?

man mmap(2):
..
       MAP_SHARED Share this mapping  with  all  other  processes
                  that map this object.  Storing to the region is
                  equivalent to writing to the  file.   The  file
                  may  not  actually be updated until msync(2) or
                  munmap(2) are called.
..
man msync(2):
..
DESCRIPTION
       msync  flushes  changes made to the in-core copy of a file
       that was mapped into memory using mmap(2)  back  to  disk.
       Without  use  of  this  call  there  is  no guarantee that
       changes are written back before munmap(2) is  called.   To
.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac28 #1 SMP Thu Mar 29 16:41:17 CEST 2001 i686

