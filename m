Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVCMSgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVCMSgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVCMSgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 13:36:11 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22935 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261416AbVCMSgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 13:36:07 -0500
Date: Sun, 13 Mar 2005 19:32:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Capabilities across execve
Message-ID: <20050313183257.GB1427@elf.ucw.cz>
References: <1110627748.2376.6.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110627748.2376.6.camel@boxen>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This makes it possible for a root-task to pass capabilities to
> nonroot-task across execve. The root-task needs to change it's
> cap_inheritable mask and set prctl(PR_SET_KEEPCAPS, 1) to pass on
> capabilities. 
> At execve time the capabilities will be passed on to the new
> nonroot-task and any non-inheritable effective and permitted
> capabilities will be masked out.
> The effective capability of the new nonroot-task will be set to the
> maximum permitted.
> 
> >From here on the inheritable mask will be passed on unchanged to the new
> tasks children unless told otherwise (effectively the complete
> capability state is passed on).
> 
> With a small insert of prctl(PR_SET_KEEPCAPS, 1) into pam_cap.c at the
> correct place this makes pam_cap work as expected. I'm also attaching a
> test-case that tests capabilities across setuid => execve (makes the new
> task inherit CAP_CHOWN).

FWIV, I think this is good idea; this way capabilities will not only
be castle in the sky, but also will be actually usable.
								Pavel


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
