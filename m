Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVEAW2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVEAW2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVEAW2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:28:48 -0400
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:35506 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261179AbVEAW2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:28:46 -0400
Date: Sun, 1 May 2005 18:24:03 -0400
From: Adam Belay <ambx1@neo.rr.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] properly stop devices before poweroff
Message-ID: <20050501222403.GF3951@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050421111346.GA21421@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421111346.GA21421@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 01:13:46PM +0200, Pavel Machek wrote:
> 
> Without this patch, Linux provokes emergency disk shutdowns and
> similar nastiness. It was in SuSE kernels for some time, IIRC.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Hi Pavel,

Although I like using pm_message_t, I'm not sure if we want to commit to only
PMSG_SUSPEND and PMSG_FREEZE for shutdown and reboot.  Would it be possible
to create a PMSG_HALT and PMSG_REBOOT?  I think this would give drivers more
control and flexability to make the right decision.  What is your opinion?

Of course, I'm still considering the posibility that we really want to do
PMSG_SUSPEND on a shutdown.  This may work ok on X86, I'm not sure about other
architectures.

I know you mentioned previously adding more flags and data to pm_message_t,
what exactly are your plans?

Thanks,
Adam
