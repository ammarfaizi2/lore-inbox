Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbUKRDyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUKRDyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUKRDx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:53:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:36762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262388AbUKRDxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:53:12 -0500
Date: Wed, 17 Nov 2004 19:52:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schaffner <schaffner@gmx.li>
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: HFS+ Bug which causes coreutils "make test" to fail
Message-Id: <20041117195236.475d0922.akpm@osdl.org>
In-Reply-To: <CA837452-38E4-11D9-8FA5-0003931E0B62@gmx.li>
References: <CA837452-38E4-11D9-8FA5-0003931E0B62@gmx.li>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schaffner <schaffner@gmx.li> wrote:
>
> I'm installing my system using an HFS+ partition as root.
> When I installed the GNU coreutils, I noticed that some test fail, even 
> though they succeed on other fs such as ext2.
> I've tracked down one failure to the following:
> 
> mkdir a; chmod 1777 a; touch a/b; su otheruser -c "rm -rf a"
> 
> gives differing results. On ext2:
> 
> rm: cannot remove 'a': Permission denied
> 
> On HFS+:
> 
> rm: reading directory 'a/b': Not a directory
> rm: cannot remove directory 'a': Directory not empty
> 
> 
> The other failure related to the fact that all pipe files are suffixed 
> by "|", and all links by "@" when doing "ls -1F" on HFS+
> 

What is the kernel version?
