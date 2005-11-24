Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVKXNHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVKXNHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVKXNHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:07:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:31383 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750811AbVKXNHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:07:10 -0500
Message-ID: <4385BAFC.7070906@op5.se>
Date: Thu, 24 Nov 2005 14:07:08 +0100
From: Andreas Ericsson <ae@op5.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511240737.59153.tomlins@cam.org>
In-Reply-To: <200511240737.59153.tomlins@cam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> Something strange here.   After a cg-update, I had no tag for rc2.   Checking
> showed no problems so I used cg-clone to get another copy of the repository.
> Still no rc2.
> 
> ed@grover:/usr/src/2.6$ cg-version
> cogito-0.16rc2 (73874dddeec2d0a8e5cd343eec762d98314def63)
> ed@grover:/usr/src/2.6$ git --version
> git version 0.99.9.GIT
> 
> cg-clone http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6
> 

This happened a while ago to someone else too. Apparently the http 
transport needs serverside help (git-update-server-info or some such 
must be run on the remote side).

Unless you're restricted by firewalls and other you could try

git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 2.6

which works flawlessly for me although it takes quite some time to 
transfer all the data.

Linus, HPA: Are the packs cached on kernel.org? It seems to be at least 
a minute before the transfers start.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
