Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268527AbUJJWIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbUJJWIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUJJWIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 18:08:52 -0400
Received: from smtp09.auna.com ([62.81.186.19]:61070 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S268527AbUJJWIu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 18:08:50 -0400
Date: Sun, 10 Oct 2004 22:08:49 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: udev: what's up with old /dev ?
To: Lista Mdk-Cooker <cooker@linux-mandrake.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1097446129l.5815l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I have just remembered that udev mounts /dev as a tmpfs filesystem, _on top_
of the old /dev directory. I have just booted to single user mode,
and checked that the old /dev is wasting around 13000 files (inodes) in my
box. Space is not an issue, that is around 480 Kb.

A couple questions:

- Is it possible to boot with an empty /dev, until udev builds it ?
- If this is not the case, which are the minimal nodes that should be
  present ?
- For any answer to previous question, shouldn't the distro set up minimal
  /dev (empty or with a few nodes) and _delete_ the old /dev tree ?

I don't remember exactly, but there are scripts at initscripts run before
udev. As I understand it, udev should be the very first thing to run, as
anything after it will probably need a /dev/something....

Why my simple logic does not work ?

(As I CC both cooker and LKML, this is a cooker specific question: could anybody
who has installed 10.1 from scratch, ie not an update, boot to runlevel 1 and
list his /dev)

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


