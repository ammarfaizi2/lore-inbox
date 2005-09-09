Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbVIIOIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVIIOIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 10:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVIIOIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 10:08:46 -0400
Received: from main.gmane.org ([80.91.229.2]:11149 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964810AbVIIOIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 10:08:45 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: aoe fails on sparc64
Date: Fri, 09 Sep 2005 10:06:12 -0400
Message-ID: <87r7bygwtn.fsf@coraid.com>
References: <3afbacad0508310630797f397d@mail.gmail.com>
	<87vf1mm7fk.fsf@coraid.com>
	<20050831.232430.50551657.davem@davemloft.net>
	<87k6i0bnyn.fsf@coraid.com>
	<3afbacad05090309064b3cad87@mail.gmail.com>
	<87ll2agcq0.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: "David S. Miller" <davem@davemloft.net>,
       Jim MacBaine <jmacbaine@gmail.com>
X-Gmane-NNTP-Posting-Host: adsl-19-26-204.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:p7Q/2D2JrceJ048+LILnG5ur23o=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin <ecashin@coraid.com> writes:

...
> Let's take this discussion off the lkml, because I doubt there's a
> problem with the aoe driver in the kernel, and I can easily follow up
> to the lkml with a synopsis if it turns out I'm wrong.

It looks like I was probably wrong.  I need to do some debugging, but
the only sparc64 machine here at hand is in use.

If anybody would be up for running 2.6.13 on a sparc64 host and
running tests with a patched aoe driver, please let me know.  A test
would look something like this, using an x86 host and a sparc64 host
on the same LAN.

  x86$ dd if=/dev/zero of=/tmp/0x1234567 bs=1k count=1 seek=19088742
  x86$ vblade 0 1 eth0 /tmp/0x1234567

  sparc64$ rmmod aoe
  sparc64$ cd ~/linux-2.6.13
  sparc64$ patch -p1 < aoe.diff
  sparc64$ make && make modules_install
  sparc64$ modprobe aoe

I'd email you patches, and you'd email me the printk messages that
show up in the logs.  Such help would be much appreciated.

-- 
  Ed L Cashin <ecashin@coraid.com>

