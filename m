Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVGHKEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVGHKEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVGHKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:04:22 -0400
Received: from gw.alcove.fr ([81.80.245.157]:37539 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262453AbVGHKCZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:02:25 -0400
Subject: Re: GIT tree broken?
From: Stelian Pop <stelian@popies.net>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
References: <Pine.SOC.4.61.0507081227540.25021@math.ut.ee>
Content-Type: text/plain; charset=utf-8
Date: Fri, 08 Jul 2005 12:00:58 +0200
Message-Id: <1120816858.4688.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 08 juillet 2005 à 12:30 +0300, Meelis Roos a écrit :
> I'm trying to sync with 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git 
> with cogito cg-update (cogito 0.11.3+20050610-1 Debian package) and it 
> fails with the following error:
> 
> Applying changes...
> error: cannot map sha1 file 043d051615aa5da09a7e44f1edbb69798458e067
> error: Could not read 043d051615aa5da09a7e44f1edbb69798458e067
> cg-merge: unable to automatically determine merge base

I see this too, with the latest cogito git tree, reproductible even in a
fresh environment:

$ rm -rf linux-2.6.git
$ cg-clone
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6.git
defaulting to local storage area

11:57:48
URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/refs/heads/master[41/41] -> "refs/heads/origin" [1] 
progress: 2 objects, 981 bytes
error: File 2a7e338ec2fc6aac461a11fe8049799e65639166
(http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects/2a/7e338ec2fc6aac461a11fe8049799e65639166) corrupt

Cannot obtain needed blob 2a7e338ec2fc6aac461a11fe8049799e65639166
while processing commit 0000000000000000000000000000000000000000.
cg-pull: objects pull failed
cg-init: pull failed

Stelian.
-- 
Stelian Pop <stelian@popies.net>

