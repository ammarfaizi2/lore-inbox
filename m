Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbTCZXrA>; Wed, 26 Mar 2003 18:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCZXq7>; Wed, 26 Mar 2003 18:46:59 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:24588 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S262649AbTCZXq6>; Wed, 26 Mar 2003 18:46:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: setfs[ug]id syscall return value and include/linux/security.h question
Date: 26 Mar 2003 23:33:08 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b5tdbk$hoj$1@abraham.cs.berkeley.edu>
References: <20030326181509.Q13397@devserv.devel.redhat.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1048721588 18195 128.32.153.211 (26 Mar 2003 23:33:08 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 26 Mar 2003 23:33:08 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek  wrote:
>Before include/linux/security.h was added, setfsuid/setfsgid always returned
>old_fsuid, no matter if the fsuid was actually changed or not.

Out of curiousity:

Do you have any idea why setfsuid() returns the old fsuid, rather than
0 or -EPERM like all the other set*id() calls?

I find it mysterious that setfsuid()'s interface is so different.
It is also strange that setfsuid() has no way to indicate whether the
call failed or succeeded.  Does this inconsistency with the rest of the
set*id() interface strike anyone else as a little odd?

It is also mysterious that there is no getfsuid() call.  One has to use
/proc to find this information.  Do you have any idea why the fsuid/fsgid
interface was designed this way?  Is this an old kludge that we now have
to live with, was it designed this way for a reason, or do we have the
opportunity to fix the semantics of the interface?
