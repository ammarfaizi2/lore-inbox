Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWJEQin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWJEQin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWJEQin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:38:43 -0400
Received: from srvh02.vc-server.de ([83.246.78.195]:63135 "EHLO
	srvh02.vc-server.de") by vger.kernel.org with ESMTP id S932164AbWJEQim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:38:42 -0400
Date: Thu, 5 Oct 2006 18:38:30 +0200
From: Dennis Heuer <dh@triple-media.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sunifdef instead of unifdef
Message-Id: <20061005183830.351a0a2f.dh@triple-media.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I may have been too hasty in calling it dead. However, I don't know
where you got it from but I just did a google and found nothing
original. Only deps, rpms, and so forth. I started a search at
Freshmeats and found it besides sunifdef. The freshmeat entry was from
2000 and the last noted update was from 2001. There was no link to a
homepage but just a link to one specific release (Possibly there are
newer ones already.)

And, 10 times bigger is not an argument neither for nor against a
tool. I'd rather like to see unifdef slip from my harddisk in full. Now,
you decided to use this tool. Ok! So what about some more global
perspective. Shouldn't it be useful for others too, then (So that it's
not only on disk for your project.) I at least pledge for sunifdef
compatibility, which should be possible because I already installed the
headers with it (though it produced some 'remarks', there doesn't seem
to be a difference between this installation and a previous one on my
old system--except that in the latter case I lost all other files
in /usr/include because there was no hint blinking anywhere that 'make
headers_install' would not just copy to but overwrite the include
directory. Playing with INSTALL_HDR_PATH, thus, is quite dangerous!)

However, there are three main reasons why I pledge for sunifdef
compatibility:

1. There is a project page and an inviting community
2. There is HTML documentation
3. They use autotools, which is distributor and administrator-friendly
(just works like the rest, and installation can be automated together
with other packages in one rush and with one simple script that uses
one strategy--very nice that is!)

Now to unifdef. Got it working. An old .o file caused the problem.
Still there is an error output:

gcc -O2 -m64   -c -o unifdef.o unifdef.c
unifdef.c: In function 'main':
unifdef.c:129: warning: incompatible implicit declaration of built-in
function 'exit'
unifdef.c:157: warning: incompatible implicit declaration of built-in
function 'exit'
unifdef.c:180: warning: incompatible implicit declaration of built-in
function 'exit'
gcc unifdef.o -o unifdef

Regards,
Dennis

Ps: am off the list now.
