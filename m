Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUIAXD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUIAXD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUIAXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:00:59 -0400
Received: from smtp07.auna.com ([62.81.186.17]:38615 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S267497AbUIAXAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:00:04 -0400
Date: Wed, 01 Sep 2004 22:59:57 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Module unloading policy (should be killed from .config ?)
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.4
Message-Id: <1094079597l.8614l.0l@werewolf.able.es>
X-Balsa-Fcc: file:///home/magallon/mail/sentbox
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Since 2.6.8.1-mm3, my system hangs when I modprobe -r ipt_MASQUERADE
(yup, you guessed, its an SMP box). Just locks hard.

A kernel build without module unloading seems to work. I heard about
module unloading not being safe, but this is the first time it hits me
seriously. If it is so dangerous and deprecated, why is still in Kconfig ?
Could you kill it and remove the code completely ? Because I suppose that
the idea is not to fix drivers...

But I guess this is going to break a lot of distros. At least Mandrake
initscripts is plenty of <modprobe, test, rmmod | modprobe -r> snippets.
Do not know if this is going to break cases like
modprobe -r xxxx || do_more

Could modprobe at least return 0 to the shell when removing ?

What is going on ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Beta 1) for i586
Linux 2.6.8.1-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #8


