Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285391AbRLGFkz>; Fri, 7 Dec 2001 00:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285416AbRLGFkf>; Fri, 7 Dec 2001 00:40:35 -0500
Received: from pixar.pixar.com ([138.72.10.20]:16602 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S285391AbRLGFkZ>;
	Fri, 7 Dec 2001 00:40:25 -0500
Date: Thu, 6 Dec 2001 21:40:19 -0800 (PST)
From: Kiril Vidimce <vkire@pixar.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel: ldt allocation failed
Message-ID: <Pine.LNX.4.21.0112062124440.18796-100000@tombigbee.pixar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We suddenly started seeing freezing problems on a number of machines
in the past couple of days. There is no pattern as far as I can tell.
It has happened while running OpenGL apps, netscape, or even when not 
doing anything. The machine will usually just hang and while it's 
still pingable, it's totally unresponsive and you can't remotely log in.
The 2.4.3 kernel usually hangs forever; the machines with 2.4.9
kernels usually come back within 10-15 secs.

Every time this happens we see the following message in the system log:

Dec  6 21:29:00 stranger kernel: ldt allocation failed

The machines are:

Hardware:
    - IBM Intellistation M Pro 
    - dual 2 GHz P4's
    - 2 GB RAM
    - NVIDIA Quadro DCC card

Software:
    - Red Hat 7.1
    - kernel 2.4.3smp or 2.4.9smp
    - XFree 4.1
    - Ximian Gnome 1.4
    - NVIDIA drivers 1.0-1541

Once this problem occurs, even if the hang is temporary, the machine
is extremely flakey. Almost any app will start causing ldt allocation
failure messages in the system log. Only a reboot really helps.

Questions:
- Does this ring a bell to anybody? What is ldt anyway and what would 
  cause an allocation to fail?

- I still keep one of these messages in this state. Is there anything
  I can probe to get useful debugging info?

Any help would greatly be appreciated.

Thanks,
KV
--
  ___________________________________________________________________
  Studio Tools                                        vkire@pixar.com
  Pixar Animation Studios                        http://www.pixar.com/

