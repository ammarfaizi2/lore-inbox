Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTLDEPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTLDEPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:15:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:48066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262789AbTLDEPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:15:50 -0500
Date: Wed, 3 Dec 2003 20:11:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: fuzzy77@free.fr, zwane@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-Id: <20031203201149.42f58e2a.rddunlap@osdl.org>
In-Reply-To: <20031204013408.GE29119@mis-mike-wstn.matchmail.com>
References: <3FC4E8C8.4070902@free.fr>
	<Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
	<20031126233738.GD1566@mis-mike-wstn.matchmail.com>
	<3FC53A3B.50601@free.fr>
	<20031202160303.2af39da0.rddunlap@osdl.org>
	<20031203003106.GF4154@mis-mike-wstn.matchmail.com>
	<20031202162745.40c99509.rddunlap@osdl.org>
	<3FCDE506.7020302@free.fr>
	<Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com>
	<3FCE877B.3010703@free.fr>
	<20031204013408.GE29119@mis-mike-wstn.matchmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003 17:34:08 -0800 Mike Fedyk <mfedyk@matchmail.com> wrote:

| On Thu, Dec 04, 2003 at 02:01:47AM +0100, Vince wrote:
| > Zwane Mwaikambo wrote:
| > >On Wed, 3 Dec 2003, Vince wrote:
| > >
| > >
| > >>Well, I get indeed a nice oops on screen with this sysctl... but the
| > >>oops/panic does not appear on the floppy dump  :-/
| > >>
| > >>--------------------------------------------------------
| > >><0>Kernel panic: Fatal exception
| > >><4> <0>Dumping messages in 100 seconds : last chance for
| > >>Alt-SysRq...<6>SysRq :
| > >>Emergency Sync
| > >><6>SysRq : Emergency Sync
| > >><6>SysRq : Emergency Remount R/O
| > >><6>SysRq : Trying to dump through real mode
| > >><4>
| > >>---------------------------------------------------------
| > >
| > >
| > >Do you see any floppy disk activity at all? I'll see if i can come up with
| > >something.
| > 
| > Yes, there *is* floppy activity. The previous messages make it to the 
| > floppy (in that case, I experienced with 
| > Alt-Sysrq+S/Alt-Sysrq+U/Alt-Sysrq+D), but the oops doesn't...

It seems possible that these commands (above) are flushing the kernel
log buffer to disk (/var/log/messages e.g.), so that they don't need
to be saved by kmsgdump.  Have you looked in the kernel message file
for them?

| do you mean s/Alt-Sysrq+D/Alt-Sysrq+B/  ?
| 
| On 2.4 there isn't a Alt-Sysrq+D, but maybe there is on 2.6...?

The kmsgdump patch adds Alt-SysRq-D to force entry into kmsgdump
instead of getting there via a panic.

--
~Randy
