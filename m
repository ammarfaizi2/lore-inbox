Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbWFCL0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbWFCL0S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbWFCL0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:26:18 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:35024 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932613AbWFCL0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:26:17 -0400
Date: Sat, 3 Jun 2006 07:26:17 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Per CPU non locked atomic operations
Message-ID: <20060603112617.GB14581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 07:20:02 up 28 days, 14:29,  3 users,  load average: 1.11, 1.87, 1.99
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the kernel tracer I develop (LTTng : http://ltt.polymtl.ca), I see a need
that could be shared by others : I extensively use per-CPU data structures to
provide efficient tracing. In addition to that, I use atomic operations (cmpxchg
and atomic increment) to keep track of offsets in the buffer so it can be
reentrant with NMI handlers.

Would there be some larger interest for having non LOCK prefixed versions of
atomic.h functions and cmpxchg for per-CPU variable purposes ?

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
