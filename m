Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270488AbTGSDlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 23:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270461AbTGSDlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 23:41:10 -0400
Received: from mark.mielke.cc ([216.209.85.42]:55312 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S270491AbTGSDlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 23:41:05 -0400
Date: Fri, 18 Jul 2003 23:55:49 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion for a new system call: convert file handle to a cookie for transfering file handles between processes.
Message-ID: <20030719035548.GA9696@mark.mielke.cc>
References: <fb7ddfab3b.fab3bfb7dd@teleline.es> <20030718203924.N639@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718203924.N639@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do unix(7) sockets with cmsg(UCM_RIGHTS) not give you what you want?

You can have a cookie process sitting in user space waiting on a UNIX
socket. When somebody passes you the right cookie string, you send them
a file descriptor.

mark

P.S. I had to look a bit for cmsg(UCM_RIGHTS). I was more familiar with
     ioctl(I_SENDFD), which it appears that Linux does not implement.

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

