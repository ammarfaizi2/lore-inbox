Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUBZKCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbUBZKCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:02:37 -0500
Received: from users.linvision.com ([62.58.92.114]:36784 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262756AbUBZKCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:02:04 -0500
Date: Thu, 26 Feb 2004 11:02:02 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040226100202.GA7006@bitwizard.nl>
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo> <20040225234944.GD187@schottelius.org> <20040226032741.GB1177@frodo> <20040226082551.GA218@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226082551.GA218@schottelius.org>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 09:25:51AM +0100, Nico Schottelius wrote:
> I am really wondering about the error message, as "internal errors" 
> indicate for me an error in the kernel.

[...]

> And btw, do all filesystem drivers behave in this way, printing internal
> errors and displaying call traces when they find errors in the
> filesystem?

For a filesystem driver, things are clear: it's the only one writing
to the data on the drive. So when things go wrong: in principle, it's
an internal error. 

It would be nice if you'd always be able to salvage your data by
just mounting the partition, but that's not the case. A specialized
program like ...-repair or fsck will do a better job. 

Now for a logging filesystem, the assumption that it messed up itself
is even stronger than for a classical filesystem. It should be able
to handle whatever happens. 

It's very difficult to check all assumptions about what's on the disk
at every step and still have a reasonable performance. That's why some
errors may only be noticed a bit late and lead to slightly misleading
error messages. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
