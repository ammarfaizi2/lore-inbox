Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVCUFPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVCUFPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 00:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVCUFPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 00:15:33 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:1733 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261563AbVCUFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 00:15:01 -0500
From: Grant Coady <grant_nospam@dodo.com.au>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: William Beebe <wbeebe@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Date: Mon, 21 Mar 2005 16:14:57 +1100
Organization: scattered.homelinux.net
Message-ID: <hils31h6au6i816ddi1r0vffgl0ithfde6@4ax.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <16958.16187.716183.994251@wombat.chubb.wattle.id.au>
In-Reply-To: <16958.16187.716183.994251@wombat.chubb.wattle.id.au>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 14:27:55 +1100, Peter Chubb <peterc@gelato.unsw.edu.au> wrote:

>>>>>> "William" == William Beebe <wbeebe@gmail.com> writes:
>
>William> Sure enough, I created the following script and ran it as a
>William> non-root user:
>
>William> #!/bin/bash $0 & $0 &
>
>There are two approaches to fixing this.
>  1.  Rate limit fork().  Unfortunately some legitimate usges do a lot
>      of forking, and you don't really want to slow them down.
>  2.  Limit (per user) the number of processes allowed. This is what's
>      currently done; and if you as administrator want to you can set
>      RLIMIT_NPROC in /etc/security/limits.conf
>
>On an almost-single-user system such as most desktops, there isn't much
>point in setting this.  On shared systems, it can be useful.

Had to try it out of curiosity, five ssh logins at the time, 
but I hit Ctrl-S on the terminal running forkbomb, then other 
terminals responsive and I could recover, do 'killall forkbomb'.

Even 'top' segfaulted.  Machine didn't die though.  

slackware-current running 2.4.29-hf5

Just checked logs, messages: --> kernel: VFS: file-max limit 52427 reached
nothing in syslog or debug

Cheers,
Grant.

