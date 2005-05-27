Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVE0SzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVE0SzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVE0SzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 14:55:15 -0400
Received: from 12-210-11-163.client.insightBB.com ([12.210.11.163]:42506 "HELO
	thor") by vger.kernel.org with SMTP id S262534AbVE0SyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 14:54:25 -0400
Date: Fri, 27 May 2005 14:54:18 -0400
From: "J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@thor.tetracon-eng.net
To: Davy Durham <pubaddr2@davyandbeth.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: disowning a process
In-Reply-To: <42975945.7040208@davyandbeth.com>
Message-ID: <Pine.SGI.4.60.0505271447220.16016@thor.tetracon-eng.net>
References: <42975945.7040208@davyandbeth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 May 2005, Davy Durham wrote:

> Hi,  I'm not sure if there's a posix way of doing this, but wanted to check 
> if there is a way in linux.
>
> I want to have a daemon that fork/execs a new process, but don't want (for 
> various reasons) the responsibility for cleaning up those process with the 
> wait() function family.   I'm assuming that if the init process became the 
> parent of one of these forked processes, then it would clean them up for me 
> (is this assumption true?).    Besides the daemon process exiting, is there a 
> way to disown the process on purpose so that init inherits it?
>
> Thanks,
>  Davy
>

Sounds like a job for the Richard Stevens "Advanced Programming in the 
UNIX Environment" book.  Check out chapter 13, "daemon processes".  It 
explains the subtleties of process groups, signals, inheritance, etc.. 
better than most.

-Scott-
