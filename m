Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTLKNbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTLKNbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:31:49 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:38417 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264943AbTLKNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:31:35 -0500
Date: Thu, 11 Dec 2003 14:31:24 +0100
From: Willy Tarreau <willy@w.ods.org>
To: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 + tmpfs: where's my mem?!
Message-ID: <20031211133124.GA18161@alpha.home.local>
References: <3FD86904.30500@arenanetwork.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD86904.30500@arenanetwork.com.br>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 10:54:28AM -0200, dual_bereta_r0x wrote:
> root@hquest:/tmp# cat /etc/slackware-version
> Slackware 9.1.0
> root@hquest:/tmp# uname -a
> Linux hquest 2.4.23 #6 Sat Nov 29 22:47:03 PST 2003 i686 unknown unknown 
> GNU/Linux
> root@hquest:/tmp# df /tmp
> Filesystem           1K-blocks      Used Available Use% Mounted on
> tmpfs                   124024    112388     11636  91% /tmp
> root@hquest:/tmp# du -s .
> 32      .
> root@hquest:/tmp# _

maybe you have a process which creates a temporary file in /tmp, and deletes
the entry while keeping the fd open. vmware 1.2 did that, and probably more
recent ones still do. It's a very clever way to automatically remove temp
files when the process terminates.

Cheers,
Willy

