Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTL3Wro (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 17:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbTL3WpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:45:18 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:56508 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S264305AbTL3Wof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:44:35 -0500
Date: Tue, 30 Dec 2003 17:44:34 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Stupid Q regarding reading /proc/PID/mem, etc
Message-ID: <Pine.LNX.4.33L2.0312301741150.20005-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a probably annoying/dumb question:

Why does reading something that you don't have permission for from
/proc/PID, such as, oh /proc/PID/mem (normally unless you own PID you
can't read that even on lax systems) return -ESRCH to userland?  You'd
think it should return -EPERM right?

>From fs/proc/base.c::mem_read():

        if (!MAY_PTRACE(task) || !may_ptrace_attach(task))
                return -ESRCH;

Why not -EPERM?

-Calin



