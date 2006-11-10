Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161947AbWKJSkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161947AbWKJSkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161949AbWKJSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:40:55 -0500
Received: from tomts36.bellnexxia.net ([209.226.175.93]:40340 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1161947AbWKJSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:40:54 -0500
Date: Fri, 10 Nov 2006 13:40:49 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: MIPS atomic operations, "sync"
Message-ID: <20061110184049.GA24977@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:40:09 up 79 days, 15:48,  6 users,  load average: 1.26, 0.99, 0.51
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently creating a "LOCK" prefix free and memory barrier free version
of atomic.h to fulfill my tracer (LTTng) needs, which is to atomically update
per-cpu data and have a minimal performance loss.

I just came across the MIPS atomic.h and system.h implementations in 2.6.18
which brings a question :

Why are the primitives in include/asm-mips/atomic.h using the "sync"
instruction even in the UP case ? system.h cmpxchg only uses the sync in the
SMP case.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
