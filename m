Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268535AbTBOEvD>; Fri, 14 Feb 2003 23:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268536AbTBOEvD>; Fri, 14 Feb 2003 23:51:03 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:32204 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S268535AbTBOEvC>; Fri, 14 Feb 2003 23:51:02 -0500
Subject: Re: Synchronous signal delivery..
From: Keith Adamson <keith.adamson@attbi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302141554120.1296-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302141554120.1296-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Feb 2003 00:04:18 -0500
Message-Id: <1045285459.24460.97.camel@x1-6-00-d0-70-00-74-d1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 20:03, Linus Torvalds wrote:
> Could we extend that to bind "other" timers to the sigfd()? Yes. And maybe 
> we could make it easier in general to "bind" events to the fd, instead of 
> having the coupling be static (ie right now it's a static coupling at 
> "sigfd()" call time, it could be split up into a "create descriptor" and 
> "bind descriptor" thing).
> 
How about in the reverse ... being able to have multiple
processes able to dynamically connect to a single existing sigfd 
and listen for a signal?  You said that you want to reserve write()
for sending signals through the sigfd.  If you implement the 
write(sigfd, ...) then this seems to provide a very nice writer/reader
signal deliver interface with well defined end points for the sender 
and receivers.  Or maybe I'm just confused.


