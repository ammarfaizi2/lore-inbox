Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWG3Owi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWG3Owi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 10:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWG3Owi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 10:52:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51732 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750840AbWG3Owh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 10:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Cy6UAM2700chC3HeNWBgJXhKkkS5zmUXa/Hpz8YvTgL1jYvKsmm22AZEqhQQ4nQBUfg6PgfiXY8yR8hwSR9ZX+RBz1KnYckSeB9nV3c5v1pGkk3paPSeRMojCcW79UJHJbUDvQtMBfu6Y9rhPF0ct2xZS270O6E7QzGP9rthNUA=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Redeeman <redeeman@metanurb.dk>
Subject: Re: 2.6.18-rc3 - ReiserFS - warning: vs-8115: get_num_ver: not directory or indirect item
Date: Sun, 30 Jul 2006 16:53:43 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com> <1154266306.13635.28.camel@localhost>
In-Reply-To: <1154266306.13635.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301653.43919.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 15:31, Redeeman wrote:
> On Sun, 2006-07-30 at 15:08 +0200, Jesper Juhl wrote:
> > I just got a warning message with 2.6.18-rc3 that I've never seen before :
> > 
> >   ReiserFS: sda4: warning: vs-8115: get_num_ver: not directory or indirect item
> > 
> > The message showed up twice in dmesg during two parallel "make -j3"
> > builds of the 2.6.18-rc3 kernel source in two sepperate directories.
> > I've tried to reproduce it but without luck.
> > 
> > It would be nice if someone could tell me what the message means and
> > wether or not I should be worried about it.
> by default i would suggest worried mode.
> 
> what does fsck.reiserfs say?
> > 

nothing much : 

root@dragon:~# fsck.reiserfs /dev/sda4
reiserfsck 3.6.19 (2003 www.namesys.com)

*************************************************************
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will read-only check consistency of the filesystem on /dev/sda4
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
###########
reiserfsck --check started at Sun Jul 30 16:03:39 2006
###########
Replaying journal..
Reiserfs journal '/dev/sda4' in blocks [18..8211]: 0 transactions replayed
Checking internal tree..finished
Comparing bitmaps..finished
Checking Semantic tree:
finished
No corruptions found
There are on the filesystem:
        Leaves 139587
        Internal nodes 937
        Directories 33870
        Other files 516740
        Data block pointers 3875183 (1397 of them are zero)
        Safe links 0
###########
reiserfsck finished at Sun Jul 30 16:18:47 2006
###########
root@dragon:~#


-- 
Jesper Juhl <jesper.juhl@gmail.com>


