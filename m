Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbUCJTJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbUCJTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:09:23 -0500
Received: from open.nlnetlabs.nl ([213.154.224.1]:26127 "EHLO
	open.nlnetlabs.nl") by vger.kernel.org with ESMTP id S262783AbUCJTJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:09:13 -0500
Date: Wed, 10 Mar 2004 20:09:02 +0100
From: Miek Gieben <miekg@atoom.net>
To: linux-kernel@vger.kernel.org
Subject: pts/X counts on
Message-ID: <20040310190902.GA2226@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm seeing to following (obscure) thing happening:

I open an xterm, it gets the pseudo term: pts/1
I close the term and open a new one: pts/2, in stead
of pts/1.

Like this:

USER     TTY      FROM   LOGIN@   IDLE   JCPU   PCPU WHAT
miekg    pts/1    arena  19:57    3.00s  0.24s  0.11s vi bla
miekg    pts/4    arena  20:03    0.00s  0.06s  0.00s w
$ logout

login again:

USER     TTY      FROM   LOGIN@   IDLE   JCPU   PCPU WHAT
miekg    pts/1    arena  19:57    3.00s  0.25s  0.12s vi bla
miekg    pts/5    arena  20:03    0.00s  0.05s  0.00s w
        ^^^^^^^

It just counts on.... 

I'm using devfs on 2.6.4-rc3, I first noticed this in 2.6.3.
(all 2.6.4-rcX have it),

Does anybody know why this is happening?

grtz Miek

[ I'm not on this list, please CC me on replies ]
