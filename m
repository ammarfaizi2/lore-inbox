Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCCTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCCTit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVCCTil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:38:41 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:42601 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262064AbVCCS6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:58:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ohfzraF031OOOci94qZvLgz+P8Fx/Qt6PpHXO8bArpY/FpEZVEgKsllr5/oOj+Z00CC9H7ec/dgPmy+1CBCwJWRinF+44NXJj76/PuvaTCo//PL3LKbXeL9f9IpRepXx4FxC64n6Fau/b1NPnNvQ4klGtmfVyjXrlJD0Jz0NgSc=
Message-ID: <d91f4d0c0503031057306a74e1@mail.gmail.com>
Date: Thu, 3 Mar 2005 13:57:28 -0500
From: George Georgalis <georgalis@gmail.com>
Reply-To: George Georgalis <georgalis@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem with linux 2.6.11 and sa
In-Reply-To: <20050303184605.GB1061@ixeon.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050303184605.GB1061@ixeon.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
