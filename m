Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVCCRqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVCCRqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVCCRpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 12:45:51 -0500
Received: from sta.galis.org ([66.250.170.210]:39040 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S262540AbVCCRfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 12:35:10 -0500
From: "George Georgalis" <george@galis.org>
Date: Thu, 3 Mar 2005 12:34:59 -0500
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: problem with linux 2.6.11 and sa
Message-ID: <20050303173459.GC952@ixeon.local>
Reply-To: george@galis.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please keep me in cc as I'm not presently subscribed to lkml)

I recall a problem a while back with a pipe from
/proc/kmsg that was sent by root to a program with a
user uid. The fix was to run the logging program as
root. Has that protected pipe method been extended
since 2.6.8.1?


I'm very defiantly seeing a problem with the 2.6.11
kernel and my spamassassin setup. However, it's not
clear exactly where the problem is, seems like sa
but it might be 2.6.11 with daemontools + qmail +
QMAIL_QUEUE.

A sure sign of it is no logs (with debug) for
remote sa connections which score "0/0" and correct
operation with local "cat spam.txt | spamc -R"; fix
is to use the older kernel.

SA has stopped stdout logging completely with 2.6.11
in addition to the all pass score. But the message
seems to go through my temp queue (for testing) and
sent on to my local MDA. I'm not sure if it's a sa
problem with the kernel or the new kernel doing
something new with pipes from tcp connections.
Maybe the new kernel is not making files available
(eg 0 bytes), until the writing pipe is closed?
That would make my SA test a zero byte file, which
would pass, close, become full, and the file piped
to local MDA is full? ...humm then I'd get a score
of "0/5"... this sounds like a SA problem with the
new kernel, ideas?


// George


-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org

