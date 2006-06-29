Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWF2AWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWF2AWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 20:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWF2AWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 20:22:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4034 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751833AbWF2AWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 20:22:40 -0400
Subject: Re: [GIT *] make headers_install
From: David Woodhouse <dwmw2@infradead.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: torvalds@osdl.org, akpm@osdl.org, sam@ravnborg.org, arnd@arndb.de,
       jbailey@ubuntu.com, Tim Yamin <plasmaroo@gentoo.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>, alan@lxorguk.ukuu.org.uk,
       Thorsten Kukuk <kukuk@suse.de>, Clint Adams <schizo@debian.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060628234450.GB5074@linux-mips.org>
References: <1151446372.6394.295.camel@pmac.infradead.org>
	 <20060628234450.GB5074@linux-mips.org>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 01:22:01 +0100
Message-Id: <1151540522.18930.16.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 00:44 +0100, Ralf Baechle wrote:
> Thanks for the time you've been pouring into this.  Copying kernel
> header into applications clearly didn't work too well, especially for
> arch stuff (two dozen and counting ...) it was a pain and each
> distribution had different sets of hacked kernel headers.

The technical part wasn't very time-consuming at all. Arnd provided the
basic implementation, and I just tweaked it a little to use unifdef and
be a bit more selective about what we export. It's probably taken less
time than it would have done to get Fedora's 'glibc-kernheaders' package
into shape manually the way it always used to be done -- and it'll
_certainly_ be a Godsend for future updates.

The time-consuming part was chasing up those who look after similar
packages in other distributions and making sure they were happy enough
with the principle too -- tracking them down on IRC when they ignored my
emails.

The current hurdle seems to be getting Linus to take it or at least
comment, now that everyone _else_ seems to be fairly much in agreement.
I'm hoping we don't have to let it drag on till the Kernel Summit.

-- 
dwmw2

