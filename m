Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUGWDES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUGWDES (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUGWDES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:04:18 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:35238
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S267509AbUGWDER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:04:17 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Interesting race condition...
Date: Thu, 22 Jul 2004 22:04:46 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407222204.46799.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just saw a funky thing.  Here's the cut and past from the xterm...

[root@(none) root]# ps ax | grep hack
 9964 pts/1    R      0:00 grep hack HOSTNAME= SHELL=/bin/bash TERM=xterm HISTSIZE=1000 USER=root LS_COLORS=no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=
[root@(none) root]# ps ax | grep hack
 9966 pts/1    S      0:00 grep hack

Seems like some kind of race condition, dunno if it's in Fedore Core 1's ps
or the 2.6.7 kernel or what...

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

