Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422983AbWJFVoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWJFVoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422985AbWJFVoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:44:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:11196 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422983AbWJFVoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:44:01 -0400
Date: Fri, 6 Oct 2006 23:43:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@intel.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <20061006214351.GB29572@elf.ucw.cz>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> There is a problem in th following scenario(s):
> 
> boot -> suspend -> (un)plug battery -> resume
> 
> The problem arises in both cases - i.e. suspend with battery plugged in, 
> and resume with battery unplugged, or vice versa.
> 
> After resume, when the battery status has changed (plugged in -> unplegged 
> or unplugged -> plugged in) during the time when the system was sleeping, 
> the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not 
> the current state).
> 
> The following patch adds ->resume method to the ACPI battery handler, which
> has the only aim - to check whether the battery state has changed during sleep, 
> and if so, update the ACPI internal data structures, so that information 
> published through /proc/acpi/battery/*/* is correct even after suspend/resume
> cycle, during which the battery was removed/inserted.
> 
> The patch is against current ACPI git tree, but applies cleanly also 
> against -mm and probably other trees. Please apply.
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>

Looks okay to me.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
