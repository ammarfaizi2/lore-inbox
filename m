Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbTCRS7F>; Tue, 18 Mar 2003 13:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbTCRS7F>; Tue, 18 Mar 2003 13:59:05 -0500
Received: from pixar.pixar.com ([138.72.10.20]:18154 "EHLO pixar.pixar.com")
	by vger.kernel.org with ESMTP id <S262542AbTCRS7E>;
	Tue, 18 Mar 2003 13:59:04 -0500
Date: Tue, 18 Mar 2003 11:09:55 -0800
From: Lars Damerow <lars@pixar.com>
To: linux-kernel@vger.kernel.org
Subject: Problem: high CPU usage during unmount
Message-ID: <20030318190955.GC4094@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, folks!

In all kernel versions I've tried, including 2.4.20, I'm seeing very high CPU
usage (typically 99%) while my system unmounts a large number of mounts. All of
this CPU time appears to be used by the kernel's umount() call.

The slowdown seriously affects the system's interactivity, and its duration
depends on the number of umounts the system has to do. For 79 mounts, it lasts
about 16.5 seconds.

I wrote a shell script that calls umount for each of these 79 mounts in a for
loop, and running it through time shows it to take 15.6 seconds of system time
with 95% CPU consumed.

While this typically happens through amd-managed NFS mounts, I've found that it
also happens with loopback mounts.

Does this sound familiar to anyone, and if so, is there anything I can do to
stop it? I can produce more debugging information if that would be useful.

Please CC me on any responses. Thanks very much for your time!
-lars

___________________________________________________________
lars damerow
button pusher
pixar animation studios
lars@pixar.com

I want to raise my freak flag higher and higher and
I want to raise my freak flag and never be alone...  -tmbg
