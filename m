Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316023AbSE3BDw>; Wed, 29 May 2002 21:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSE3BDv>; Wed, 29 May 2002 21:03:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39858 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316023AbSE3BDu>;
	Wed, 29 May 2002 21:03:50 -0400
Date: Wed, 29 May 2002 17:48:25 -0700 (PDT)
Message-Id: <20020529.174825.66872964.davem@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, mathieu@newview.com, andre@linux-ide.org,
        dalecki@evision-ventures.com
Subject: Re: 2.4.19-pre9, IDE on Sparc, Big Disks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <UTC200205300009.g4U09ri18210.aeb@smtp.cwi.nl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andries.Brouwer@cwi.nl
   Date: Thu, 30 May 2002 02:09:53 +0200 (MEST)
   
   Precisely what happened is easiest to trace with the identify data in hand.
   For example, maybe the sparc code still has to be extended to fix the
   order of lba_capacity48 or so (in ide_fix_driveid).
   
Almost certainly this is the problem.  I am looking
at it.   
   
   BTW, this fixing in-place of the driveid is a very bad idea.
   Nobody should ever touch driveid. It is a read-only variable.

Well, you are probably right.  Currently it is defined as read-only
after ide_fix_driveid() runs on it :-)
