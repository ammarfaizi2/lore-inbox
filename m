Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbTDTHUR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 03:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDTHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 03:20:17 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:33714 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263539AbTDTHUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 03:20:16 -0400
Message-ID: <3EA24CF8.5080609@shemesh.biz>
Date: Sun, 20 Apr 2003 10:32:08 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org>
In-Reply-To: <20030420013440.GG2528@phunnypharm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>I hate asking this on top of the work you already provide, but would it
>be possible to allow rsync access to the repo itself? I have atleast 6
>computers on my LAN where I keep source trees (2.4 and 2.5), and it
>would be much less b/w on my metered T1 and on your link aswell if I
>could rsync one main "mirror" of the cvs repo and then point all my
>machines at it.
>
There is a better tool (for this particular task), called "cvsup". It 
does a wonderful job of keeping cvs repositories in synch. I realize I 
just asked for a THIRD tool, so it should only go in if the admins are 
willing to take care of it.

The idea is that it uses the full duplexity of the channel to get client 
side information about the repository on that end while downloading 
changes, thus increasing the effective bandwidth. It only falls back to 
rsynch if CVS repository specific updates are not possible. I use it on 
the Wine repository, and it does, indeed, work very efficiently.

On the negative side - as far as I could tell, neither RedHat nor 
Mandrake carry it as a standard package (Debian does, at least in unstable).

             Shachar

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


