Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTIRSry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTIRSry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 14:47:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:28893 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262011AbTIRSrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 14:47:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16233.64980.415212.495182@gargle.gargle.HOWL>
Date: Thu, 18 Sep 2003 20:47:48 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ross Boylan <RossBoylan@stanfordalumni.org>
Cc: linux-kernel@vger.kernel.org, Manoj Srivastava <srivasta@debian.org>
Subject: Re: PROBLEM: Default initial config options all N
In-Reply-To: <20030918165905.GX12620@wheat.boylan.org>
References: <20030918165905.GX12620@wheat.boylan.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Boylan writes:
 > Please cc me on replies.
 > 
 > [1.] One line summary of the problem:  
 > Defaults for oldconfig options not set correctly in recent 2.4 kernels

Define "correctly". Hint: it's user-dependent.

 > [2.] Full description of the problem/report:
 > Built 2.4.21 kernel, starting with config file from 2.4.20 and running
 > oldconfig.  *All* new config options had default values of N.  The
 > help text for the following options suggested "if unsure, pick Y":
 > PF_KEY
 > CONFIG_INET_AH
 > CONFIG_INET_ESP
 > CONFIG_INET_IPCOMP
 > CONFIG_IP_NF_TFTP
 > CONFIG_XFRM_USER

Not a bug.

 > Sample from the config dialog:
 > 
 > PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) ?
 > 
 > CONFIG_NET_KEY:
 > 
 >   PF_KEYv2 socket family, compatible to KAME ones.
 >   They are required if you are going to use IPsec tools ported
 >   from KAME.
 > 
 >   Say Y unless you know what you are doing.
 > PF_KEY sockets (CONFIG_NET_KEY) [N/y/m/?] (NEW) y

Still not a bug. oldconfig stopped and asked you what to do,
you checked the help text and chose Y.

Option authors tend to want people to enable them (enable this
cool feature!) but in real life, most are Ok to disable.

If oldconfig were to choose Y for new options, then _that_
would be a bug.
