Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966969AbWK2K3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966969AbWK2K3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966966AbWK2K3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:29:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:36595 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966913AbWK2K3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:29:45 -0500
Date: Wed, 29 Nov 2006 11:28:48 +0100
From: Chris Friedhoff <chris@friedhoff.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Implement file posix capabilities
Message-Id: <20061129112848.8e48267e.chris@friedhoff.org>
In-Reply-To: <20061127170740.GA5859@sergelap.austin.ibm.com>
References: <20061127170740.GA5859@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use this patch with 2.6.18.3.
patching: ok
configuring: ok
compiling: ok
installing: ok
running: ok
tested with httpd, smbd, nmbd, named, cupsd, ping, traceroute,
modprobe, traceroute, ntpdate, xinit, killall, eject, dhcpd, route,
qemu: ok
I use this patch as documented: http://www.friedhoff.org/fscaps.html

I also tested the patched kernel with "CONFIG_SECURITY_FS_CAPABILITIES
is not set" and xinit kills X perfectly, when the GUI is stopped.

Any other tests that might be helpful?

The webpage is updated.

Chris


On Mon, 27 Nov 2006 11:07:40 -0600
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> From: Serge E. Hallyn <serue@us.ibm.com>
> Subject: [PATCH 1/1] Implement file posix capabilities
> 
> Implement file posix capabilities.  This allows programs to be given a
> subset of root's powers regardless of who runs them, without having to use
> setuid and giving the binary all of root's powers.
> 
> This version works with Kaigai Kohei's userspace tools, found at
> http://www.kaigai.gr.jp/index.php.  For more information on how to use this
> patch, Chris Friedhoff has posted a nice page at
> http://www.friedhoff.org/fscaps.html.
> 
> Changelog:
> 	Nov 27:
> 	Incorporate fixes from Andrew Morton
> 	(security-introduce-file-caps-tweaks and
> 	security-introduce-file-caps-warning-fix)
> 	Fix Kconfig dependency.
> 	Fix change signaling behavior when file caps are not compiled in.

- snip -

--------------------
Chris Friedhoff
chris@friedhoff.org
