Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTEVFY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 01:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTEVFY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 01:24:59 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:32242 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262489AbTEVFY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 01:24:58 -0400
Subject: Re: Strange terminal problem with 2.5.6[8-9]
From: Martin Schlemmer <azarah@gentoo.org>
To: Matthew Harrell 
	<mharrell-dated-1053999362.22891b@bittwiddlers.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030522013601.GA1327@bittwiddlers.com>
References: <20030511004349.GA1366@bittwiddlers.com>
	 <20030522013601.GA1327@bittwiddlers.com>
Content-Type: text/plain
Organization: 
Message-Id: <1053581519.6507.22.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 22 May 2003 07:31:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 03:36, Matthew Harrell wrote:
> : 
> : The last working kernel I had under my X windows system was 2.5.67-bk7.  After
> : that point every 2.5.6[8-9] and bk patch has had one major problem on my
> : laptop - when I bring up a gnome-terminal or xterm the console prompt never
> : shows up.  The terminals just hang with a blinking cursor but I never get
> : a prompt.  If I reboot with the same setup into my 2.5.67 or any previous
> : kernel then everything works fine.
> : 
> : This is a Debian Sid system running gnome2.  Any ideas?
> : 
> 
> This problem still exists with all current bk patches for 2.5.69.  I'm not
> even sure where to look for the problem.  Since nobody else has reported a 
> problem I'm going to boot back to an older, working kernel and assume the 
> problem as something to do with the configuration I'm using (attached below).
> If anyone has any ideas just let me know and I'll give them a try

2.5.68 and later have depreciated devpts support in devfs.  Thus
you have to enable:

 CONFIG_DEVPTS_FS=y

and mount it during boot.  Easy way is just to add to fstab:

------------------
none	/dev/pts	devpts	defaults	0 0
------------------


Regards,

-- 
Martin Schlemmer


