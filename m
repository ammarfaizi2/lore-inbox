Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWJDUfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWJDUfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWJDUfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:35:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:38155 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751091AbWJDUfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:35:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CyDhJ2+MjJOL804etlZL76MgAtDhMnSsZrKGJdzOIUiBkH12A8Gi/ZNQYtXMxVtJhNSkjSAjlDo7/Z/q2kzOZ03+yvxk0CHGNIaaRSFeBy43MLPE5AvSWDdcRr/hIoaFds76NXxmO2vgrmtxJWRsJLzZUezonJIPfKo0diqwBDg=
Message-ID: <9a8748490610041335t519678d1u61f5775293c061e4@mail.gmail.com>
Date: Wed, 4 Oct 2006 22:35:01 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: removed sysctl system call - documentation and timeline
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With recent kernels I'm getting a lot of warnings about programs using
the removed sysctl syscal.

Examples (after 5 min of uptime here) :
root@dragon:/home/juhl# dmesg | grep "used the removed sysctl system
call" | sort | uniq
warning: process `dd' used the removed sysctl system call
warning: process `ls' used the removed sysctl system call
warning: process `touch' used the removed sysctl system call

and more can be found...


I'm not, as such, opposed to removing sysctl (and yes, I know what it
is and what it does). What I am a little opposed to is that it is
being removed on such short notice (unless I missed the memo) and that
it is hidden inside EMBEDDED.

I would like to propose that, at least for 2.6.19, it be default on
(as it is now), not hide it in EMBEDDED where people usually don't go,
some huge deprecation warnings be added, and that it then gets the
usual 6-12months before being removed (did it already get that and I'm
just slow?)...  ohhh, and correct the help text; it currently says
"...Nothing has been using the binary sysctl interface for some time
now so nothing should break if you disable sysctl syscall support" -
that's obviously false as demonstrated by the above extract from my
dmesg...

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
