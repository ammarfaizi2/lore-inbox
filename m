Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUGGNNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUGGNNE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUGGNNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:13:04 -0400
Received: from moon.tuniv.szczecin.pl ([212.14.18.12]:17416 "EHLO
	moon.tuniv.szczecin.pl") by vger.kernel.org with ESMTP
	id S265095AbUGGNLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:11:05 -0400
Date: Wed, 7 Jul 2004 14:28:05 +0200 (CEST)
From: Adam Popik <popik@moon.tuniv.szczecin.pl>
To: linux-kernel@vger.kernel.org
Subject: stupied userspace programs or kernel bug ?
Message-ID: <Pine.LNX.4.44.0407071421180.23555-100000@moon.tuniv.szczecin.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ;
That is a problem:
linux#ifconfig eth0 192.168.1.1
linux#ifconfig lo:1 192.168.1.100 netmask 255.255.255.255 up
	       ^^^^
otherlinuxonsamenet#ifconfig eth0 192.168.1.2
otherlinuxonsamenet#ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=0 ttl=64 time=2.20 ms
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=19.6 ms

That was good but:
otherlinuxonsamenet#ping 192.168.1.100
PING 192.168.1.100 (192.168.1.100) 56(84) bytes of data.
64 bytes from 192.168.1.100: icmp_seq=0 ttl=64 time=2.20 ms
64 bytes from 192.168.1.100: icmp_seq=1 ttl=64 time=19.6 ms

That are no computers on net with ip 192.168.1.100.

Why that's works (on solaris, freebsd simply don't work - thats ok )?

PS Sorry for broken english
Adam
 

