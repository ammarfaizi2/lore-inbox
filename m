Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbSLLW5f>; Thu, 12 Dec 2002 17:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLLW5e>; Thu, 12 Dec 2002 17:57:34 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:29450 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267525AbSLLW41>;
	Thu, 12 Dec 2002 17:56:27 -0500
Date: Thu, 12 Dec 2002 18:04:10 -0500 (EST)
Message-Id: <200212122304.gBCN4AH158836@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: acahalan@cs.uml.edu
Subject: [ANNOUNCE] procps 3.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This release includes user selection in top, the sysctl -e
option needed to support the Red Hat 8.0 boot scripts, and
the use of /proc/*/wchan on recent 2.5.xx kernels.

For those of you still upgrading from procps 2.0.xx releases,
you can expect:

* top can sort by any column (old sort keys available too)
* top can select a single user to display
* top can be put in multi-window mode and/or color mode
* vmstat has the -s option, as found on UNIX and BSD systems
* vmstat has the -f option, as found on UNIX and BSD systems
* watch doesn't eat the first blank line by mistake
* vmstat uses a fast O(1) algorithm on 2.5.xx kernels
* pmap command is SunOS-compatible
* vmstat shows IO-wait time
* pgrep and pkill can find the oldest matching process
* sysctl handles the Linux 2.5.xx VLAN interfaces
* top shows IO-wait time if-and-only-if your kernel computes it
* most programs 30% to 300% faster (tested on a 450 MHz MPC7400)
* ps has a new "-F" format (very nice, like DYNIX/ptx has)
* ps with proper BSD process selection
* better handling of very long uptimes

There's a procps-feedback@lists.sf.net mailing list you can
use for feature requests, bug reports, and so on. Use it!
Feedback makes things happen.

http://procps.sf.net/
http://procps.sf.net/procps-3.1.3.tar.gz

------------- recent changes -------------

procps-3.1.2 --> procps-3.1.3

uses /proc/*/wchan files when available
top: user selection
sysctl: add -e for Red Hat 8.0 boot scripts  
sysctl: the obvious --help, -V, and --version
sysctl: some command line error checking
w: stdout, not stderr -- thanks to Sander van Malssen

procps-3.1.1 --> procps-3.1.2

better RPM generation
use C99 features
some seLinux fixes
now count Inact_laundry as needed  #172163
ps: fewer globals
ps: hardware-enforced buffer protection
ps: 1 kB smaller
top: B command added (for bold on/off)
top: handle old (and future) config files
top: man page tweak
top: old sort keys     #167249
top: out-of-bounds RT as "RT"
top: several times faster
top: t command fixed
vmstat: -f
vmstat: -s
w: much faster
watch: don't drop empty lines   #171005
watch: re-indented

procps-3.1.0 --> procps-3.1.1

vmstat faster on 2.5.xx kernels
vmstat header fixed
vmstat -a re-fixed
