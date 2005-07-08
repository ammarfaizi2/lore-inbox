Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVGHL2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVGHL2E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVGHL2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:28:04 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:51921 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262433AbVGHL2C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:28:02 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Stelian Pop <stelian@popies.net>
Subject: Re: GIT tree broken? (rsync depreciated)
Date: Fri, 8 Jul 2005 07:28:16 -0400
User-Agent: KMail/1.8.1
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee> <1120816858.4688.4.camel@localhost.localdomain>
In-Reply-To: <1120816858.4688.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507080728.17192.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I resync(ed) cg and rebuild this morning and it worked fine.  

On another tack.  Updating the kernel gave a message that rsync is depreciated and
will soon be turned off.  How should we be updating git/cg trees now?

Thanks
Ed Tomlinson

On Friday 08 July 2005 06:00, Stelian Pop wrote:
> Le vendredi 08 juillet 2005 à 12:30 +0300, Meelis Roos a écrit :
> > I'm trying to sync with 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> > with cogito cg-update (cogito 0.11.3+20050610-1 Debian package) and it 
> > fails with the following error:
> > 
> > Applying changes...
> > error: cannot map sha1 file 043d051615aa5da09a7e44f1edbb69798458e067
> > error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
> > cg-merge: unable to automatically determine merge base
> 
> I see this too, with the latest cogito git tree, reproductible even in a
> fresh environment:
> 
> $ rm -rf linux-2.6.git
> $ cg-clone
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6.git
> defaulting to local storage area
> 
> 11:57:48
> URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master[41/41] -> "refs/heads/origin" [1] 
> progress: 2 objects, 981 bytes
> error: File 2a7e338ec2fc6aac461a11fe8049799e65639166
> (http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) corrupt
> 
> Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
> while processing commit 0000000000000000000000000000000000000000.
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> Stelian.
