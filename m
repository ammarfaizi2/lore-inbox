Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSGSVzR>; Fri, 19 Jul 2002 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSGSVzR>; Fri, 19 Jul 2002 17:55:17 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:52872 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317030AbSGSVzR>;
	Fri, 19 Jul 2002 17:55:17 -0400
Subject: file descriptor passing (jail related question)
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 17:58:07 -0400
Message-Id: <1027115899.2161.110.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How does file descriptor passing work.  From what I can tell it uses the
sendmsg and recvmsg calls.  Is this only process to process over a non
ip socket  on the same machine (what's the right terminology for this,
just a plain FIFO?), or could one conceivably pass a file descriptor
over an ip socket?

I ask, because of jail.  If it's just a FIFO, then one can secure fd
passing in a jail by controlling who can talk on a socket (since
persumably fd passing is used over a pre-existing fd, and there are no
pre-existing fd's to outside the jail....)

If it can be transmited over IP, its a much more serious issue, as all
one has to do is crack a jail (root inside the jail), crack the local
system (regular user) run a program that talks to the local system over
ip, and have the cracked regular user pass a fd in.

Any other points to read that I can learn about fd passing would be
appreciated as well, as I have never used this feature in my programs,
so am somewhat ignorant in regards to it.

thanks,

shaya potter

