Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132352AbRDAMva>; Sun, 1 Apr 2001 08:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDAMvV>; Sun, 1 Apr 2001 08:51:21 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:45832 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132352AbRDAMvP>;
	Sun, 1 Apr 2001 08:51:15 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: chip@valinux.com (Chip Salzenberg)
cc: hbryan@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt) 
In-Reply-To: Your message of "Sun, 01 Apr 2001 01:01:59 PST."
             <E14jdkF-0007Ps-00@tytlal> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Apr 2001 05:50:22 -0700
Message-ID: <1140.986129422@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Apr 2001 01:01:59 -0800, 
chip@valinux.com (Chip Salzenberg) wrote:
>In article <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain> you write:
>Why not have a kernel thread and use standard RPC techniques like
>sockets?  Then you'd not have to invent anything unimportant like
>Yet Another IPC Technique.

kerneld (kmod's late unlamented predecessor) used to use Unix sockets
to communicate from the kernel to the daemon.  It forced everybody to
link Unix sockets into the kernel but there are some people out there
who want to use it as a module.  Also the kernel code for communicating
with kerneld was "unpleasant", see ipc/msg.c in a 2.0 kernel.

