Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWKOPI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWKOPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWKOPI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:08:27 -0500
Received: from cadalboia.ferrara.linux.it ([195.110.122.101]:28375 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1030538AbWKOPI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:08:26 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: strange behaviour with x86_64
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 214651
Date: Wed, 15 Nov 2006 16:08:23 +0100
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200611151608.23992.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm seeing a strange behaviour on a dual opteron machine (or, at least it seem 
so to me) and I need some advice.
The hardware is: dual opteron 2.4, dual core, 2GB ram
This machine runs apache webserver/mod_perl. Due to some bug in perl code, 
often the machine runs out of memory, and oomkiller triggers.
Nothing wrong in this, but while this happens the machine freezes: no activity 
is possible, it only answers to "ping" packets and to sysreq commands. Even 
the console login freezes.
The only possible recovery is to reboot the machine. I've tried, to collect 
more information, to reduce the swap space from 2Gb to 200Mb, and in fact the 
lockup happens more often. 
It seems to me that when the kernel runs out of memory (swap+phys), it is 
unable to recover in any way, even if the oomkiller removes a good deal of 
memory hog processes.
Maybe this is the usual behaviour, but I'm a little bit perplexed.
I've used netconsole to collect more data, and I'm attaching a sysreq-t output 
obtained during the "lockup" phase. Thanks to Andrea for some useful hints on 
how to use netconsole facility :)
Let me know if you need more information, or if this a "no issue" situation :)

the sysreq log file can be found at this url:

http://members.ferrara.linux.it/cova/sysreq.log


Speaking of netconsole, I've been able to collect information from sysreq, but 
no boot messages are sent over the network; only when the userland comes up I 
can see messages on the remote machines. As anyone some hints about this?

Thanks. 


-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
