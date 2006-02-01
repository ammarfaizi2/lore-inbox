Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422971AbWBAWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422971AbWBAWLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422974AbWBAWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:11:17 -0500
Received: from nutty.inf.ed.ac.uk ([129.215.216.3]:45235 "EHLO
	nutty.inf.ed.ac.uk") by vger.kernel.org with ESMTP id S1422971AbWBAWLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:11:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17377.6410.121318.124897@palau.inf.ed.ac.uk>
In-Reply-To: <20060201172653.GA22700@suse.de>
References: <17374.5399.546606.933186@palau.inf.ed.ac.uk>
	<20060201172653.GA22700@suse.de>
X-Mailer: VM 7.18 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
From: Julian Bradfield <jcb@inf.ed.ac.uk>
To: Olaf Dabrunz <od@suse.de>
cc: linux-kernel@vger.kernel.org, lhofhansl@yahoo.com
Subject: Re: TIOCCONS security revisited
Date: Wed, 1 Feb 2006 20:24:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The problem is that TIOCCONS causes security problems.
>
>Please rehash what I wrote in the thread. Essentially, these are my
>points (citing myself here):

If you insist, I will rehash them, though they are not really relevant.

>    the ioctl TIOCCONS allows any user to redirect console output to
>    another tty. This allows anyone to suppress messages to the console
>    at will.

I do not propose returning to this situation.

>[and in a later mail:]
>    Changing the ownership on /dev/console causes security problems
>    (that user can usually access the current virtual terminal anytime,
>    and the current one may not belong to him).

If this is seen as a problem, it should be fixed in the virtual
terminal system. /dev/console and TIOCCONS exist and work in many
Unices, not just Linux.

>Also I refered to a security advisory for SunOS which describes one of
>the problems (hijacking):
>http://www.cert.org/advisories/CA-1990-12.html

And how did Sun fix it? They fixed it by restricting TIOCCONS to users
who have read access to the console - more liberal than my proposal!

>And I said that there are alternatives to /dev/console, and a commonly
>used one is /dev/xconsole (see below how to use this). It does not have

I do not have the option of using /dev/xconsole.
I use machines that I don't administer, and on all of them for the
last 15 years until the recent breakage, "xterm -C" worked.

>syslog/syslog-ng). But it also does not receive the messages that are
>simply written to /dev/console.

Exactly. I have an array of programs that write to /dev/console in the
expectation that the message will be read by the person sitting at the
console.

>The latter problem still needs to be fixed, but is seldom a real
>problem. AFAICS nowadays only scripts that run at boot time write to
>/dev/console. The user has several ways to look at these messages

As I have indicated, there is a world outside your experience of
Linux. As well as my own scripts, the machines one which I work are
set up to have syslog write urgent messages to /dev/console.

>If you want this problem fixed, consider copying messages to
>/dev/console with a demon to a logging facility. Have a look at
>bootlogd/blogd.

I do not administer the machines. If you hadn't broken TIOCCONS,
everything would still work.

>All this can be done by using /dev/xconsole.

Which is not available.

>Xconsole fails because by default it tries to use /dev/console. You can
>avoid that by setting the resources to point to another file, e.g.
>/dev/xconsole:

which is not available.

