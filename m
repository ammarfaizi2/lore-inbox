Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272942AbTG3PNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272944AbTG3PNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:13:15 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:59012 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S272942AbTG3PME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:12:04 -0400
Date: Wed, 30 Jul 2003 07:12:19 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: apm suspend breaks ALSA
Message-ID: <20030730151219.GD6639@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
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

Greetings,

I have a laptop with the es1978 ALSA sound driver built into the kernel.  
When I go through a suspend / resume cycle using apm, the sound system 
does not recover and loud static comes from the speakers instead of 
music / voice / etc.  On boot, ALSA works just fine.

One solution appears to be building ALSA as modules and unloading / 
reloading them, after a suspend / resume cycle.  With 2.4.xx and the OSS 
drivers built in, this wasn't an issue.

Now that I've got them built as modules and have a 'sound' script in 
/etc/apm/events.d/ that does the loading and unloading I'm happy, but I 
figured I'd report the issue anyway.

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

