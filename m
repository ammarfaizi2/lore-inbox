Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161367AbWG1Xi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161367AbWG1Xi4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWG1Xiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:38:55 -0400
Received: from colin.muc.de ([193.149.48.1]:38920 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1161367AbWG1Xiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:38:55 -0400
Date: 29 Jul 2006 01:38:51 +0200
Date: Sat, 29 Jul 2006 01:38:51 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
Message-ID: <20060728233851.GA35643@muc.de>
References: <20060727015639.9c89db57.akpm@osdl.org> <1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728144854.44c4f557.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > syslog from working 2.6.18-rc2 located at:
> > http://www.microgate.com/ftp/linux/test/syslog

What happened to the new lines? It looks like a bad alphabet soup

Do you perhaps have a boot log from before 2.6.17 (e.g. 2.6.16)? 
Preferably with newlines.

> 
> A bisection search would be useful, if you have the time.  I'd zero in on
> the x86_64 tree initially.  Perhaps x86_64-mm-i386-io-apic-access.patch.

It's remove-timer-fallback likely. I was working on that already.

Some boards go into the timer fallback path since 2.6.17/64bit for so 
far unknown reasons and that doesn't work anymore because I removed the 
fallback path.

-Andi
