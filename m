Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261252AbREQMnO>; Thu, 17 May 2001 08:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbREQMnE>; Thu, 17 May 2001 08:43:04 -0400
Received: from www.inreko.ee ([195.222.18.2]:39399 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S261252AbREQMmx>;
	Thu, 17 May 2001 08:42:53 -0400
Date: Thu, 17 May 2001 14:44:42 +0200
From: Marko Kreen <marko@l-t.ee>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] preserve symlinked .configs
Message-ID: <20010517144442.B1993@l-t.ee>
In-Reply-To: <3B03BD9D.16662D1C@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B03BD9D.16662D1C@uow.edu.au>; from andrewm@uow.edu.au on Thu, May 17, 2001 at 10:01:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 10:01:33PM +1000, Andrew Morton wrote:
> When one has several machines it is nice to keep each
> machine's .config under revision control.  Then, on
> each machine,
> 
> 	ln [-s] .config-$(hostname -s) .config
> 
> Problem is, `make menuconfig/oldconfig/config' goes and
> removes your link, causing much irritation.

IMHO currect behaviour is the Right Thing.  Think of 'cp -al' on
trees.  Patching one does not affect another, because patch()
does not modify files, it creates new file.  If I use your patch
and have 'cp -al'-d trees which happen to have .config inside,
doing 'make *config' in one tree will affect another.  Thats
wrong.

-- 
marko

