Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVGLR0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVGLR0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVGLRYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:24:23 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:50125 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261709AbVGLRYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:24:16 -0400
Date: Tue, 12 Jul 2005 10:24:07 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] suspend: update documentation
Message-Id: <20050712102407.0fce8b7c.rdunlap@xenotime.net>
In-Reply-To: <20050712090510.GG1854@elf.ucw.cz>
References: <20050712090510.GG1854@elf.ucw.cz>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005 11:05:10 +0200 Pavel Machek wrote:

| Update suspend documentation.
| 
| Signed-off-by: Pavel Machek <pavel@suse.cz>
| 
| ---
| 
| diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
| --- a/Documentation/power/swsusp.txt
| +++ b/Documentation/power/swsusp.txt
| @@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
|  system is shut down or suspended. Additionally use the encrypted
|  suspend image to prevent sensitive data from being stolen after
|  resume.
| +
| +Q: Why we cannot suspend to a swap file?

Q: Why can't we suspend to a swap file?
or
Q: Why can we not suspend to a swap file?

| +
| +A: Because accessing swap file needs the filesystem mounted, and
| +filesystem might do something wrong (like replaying the journal)
| +during mount. [Probably could be solved by modifying every filesystem
| +to support some kind of "really read-only!" option. Patches welcome.]
| diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
| --- a/Documentation/power/video.txt
| +++ b/Documentation/power/video.txt
| @@ -46,6 +46,12 @@ There are a few types of systems where v
|    POSTing bios works. Ole Rohne has patch to do just that at
|    http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
|  
| +(8) on some systems, you can use the video_post utility mentioned here:
| +  http://bugzilla.kernel.org/show_bug.cgi?id=3670. Do echo 3 > /sys/power/state

That attachment is weird for me.  It downloads as "attachment.cgi", but
it's a tar.gz file.  :(        (using firefox if it matters)

| +  && /usr/sbin/video_post - which will initialize the display in console mode.
| +  If  you are in X, you can switch to a virtual terminal and back to X using
| +  CTRL+ALT+F1 - CTRL+ALT+F7 to get the display working in graphical mode again.


---
~Randy
