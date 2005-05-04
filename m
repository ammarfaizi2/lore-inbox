Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVEDNb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVEDNb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVEDNb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:31:56 -0400
Received: from main.gmane.org ([80.91.229.2]:3772 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261818AbVEDNbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:31:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: System call v.s. errno
Date: Wed, 04 May 2005 15:30:02 +0200
Message-ID: <yw1xoebr9l0l.fsf@ford.inprovide.com>
References: <Pine.LNX.4.61.0505040849150.8743@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:0Oy83ee+gIf+YzDBP50X8SLc3/0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <linux-os@analogic.com> writes:

> Does anybody know for sure if global 'errno' is supposed to
> be altered after a successful system call? I'm trying to
> track down a problem where system calls return with EINTR
> even though all signal handlers are set with SA_RESTART in
> the flags. It appears as though there may be a race somewhere
> because if I directly set errno to 0x1234, within a few
> hundred system calls, it gets set to EINTR even though all
> system calls seemed to return 'good'. This makes it
> hard to trace down the real problem.
>
> The answer is not obvious because the 'C' runtime library
> doesn't really give access to 'errno' instead it is dereferenced
> off some pointer returned from a function called __errno_location().

The kernel knows nothing about errno.  Have you tried using strace to
check the actual return values of the system calls?

> This problem does not exist with Linux-2.4.x. It started to show
> up when user's updated their machines to newer RH stuff that uses
> linux-2.6.5-1.358.

So go file a bug with redhat.  It wouldn't be the first time they ship
broken stuff.

-- 
Måns Rullgård
mru@inprovide.com

