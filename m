Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284432AbRLFQHh>; Thu, 6 Dec 2001 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284485AbRLFQH0>; Thu, 6 Dec 2001 11:07:26 -0500
Received: from 24-28-205-10.mf3.cox.rr.com ([24.28.205.10]:3590 "EHLO
	24-28-205-10.mf3.cox.rr.com") by vger.kernel.org with ESMTP
	id <S284432AbRLFQHJ>; Thu, 6 Dec 2001 11:07:09 -0500
Date: Thu, 6 Dec 2001 11:07:14 -0500
From: Greg Hennessy <gsh@cox.rr.com>
To: linux-kernel@vger.kernel.org
Subject: horrible disk thorughput on itanium
Message-ID: <20011206110713.A8404@cox.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently installed a  both a Dell dual cpu 2500 server (dual 1.6 ghz
ia32 chips) and a dell 7150 (dual IA64 chips). My users complained
that the disk io speed on the itanium seemed very slow, even though
both servers have a megaraid controller with seagate cheetah
disks. Bonnie also shows the ia64 machine having worse throughput than
the ia32 machine. 

[root@hydra bonnie]# cat bonnie.hydra bonnie.leo 
              -------Sequential Output-------- ---Sequential Input--
	      --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block---
	      --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU
/sec %CPU
          100  1765 100.0 282891 100.1 377295 100.0  2058 100.0 592709
	  99.5 51920.4 196.5
              -------Sequential Output-------- ---Sequential Input--
	      --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block---
	      --Seeks---
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU
/sec %CPU
          100 17049 100.1 265197 101.0 197094 98.2 16631 100.4 675831
	  99.0 40400.0 191.9

Hydra is the itanium, leo is the 32 bit machine. The character io of
hydra is a factor of 10 slower than that of leo. Is this more likely a
kernel issue, or a glibc issue? Both machiness run standard redhat
7.1, and 2.4.9-12smp kernels.


