Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272362AbTGYUvB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272367AbTGYUsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:48:11 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:46501 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S272364AbTGYUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:44:26 -0400
Date: Fri, 25 Jul 2003 13:02:42 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.6-test1, PCMCIA cards require two insertions
Message-ID: <20030725210242.GH15537@iarc.uaf.edu>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I'm running 2.6.0-test1 on an SiS based laptop with all the PCMCIA 
network and serial drivers built into the kernel.  When the system boots 
with a PCMCIA cardbus card in place, the card doesn't show up.  I unplug 
the card and plug it back in, and then the kernel "sees" it and it 
works.  If I unplug it again, I have to go through a plug - unplug - 
plug cycle before it recognizes it.  As if it only recognizes the card 
on even numbered insertion events.

My modem card is not a cardbus card (no gold colored strip on the top) 
and it exhibits the same plug - unplug - plug requirement.  If it's in 
the slot when the computer boots, however, it will get set up, because 
the pcmcia-cs cardmgr sets it up via the sysinit scripts.

Any thoughts on why these cards require more than one insertion before 
they're recognized?  Bug / feature?

Thanks,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

