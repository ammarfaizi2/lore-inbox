Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbTFRPx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFRPx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:53:59 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:19075 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265304AbTFRPx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:53:58 -0400
From: jlnance@unity.ncsu.edu
Date: Wed, 18 Jun 2003 12:07:54 -0400
To: linux-kernel@vger.kernel.org
Subject: socket vs pipe difference in /proc/pid/fd
Message-ID: <20030618160754.GA14475@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I am running 2.4.20 and have run into something that may be a bug.

I am hacking some stuff together to debug a distributed application.
As part of this, I attempt to open /proc/pid/fd/0 and /proc/pid/fd/1
for a process.  These descriptors are a socket, created with the
socketpair() system call in the processes parent.  When I try to
open these sockets, from the shell, I get a message about the open
failing due to the /proc/pid/fd/0 being an invalid devicde.

If I change the parent application so that it uses 2 pipes rather than
a socketpair, then I have no problems opening the /proc files.

Is this difference between pipes and sockets deliberate?

Thanks,

Jim
