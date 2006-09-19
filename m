Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWISOu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWISOu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 10:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWISOu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 10:50:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:28357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751385AbWISOuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 10:50:25 -0400
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 19 Sep 2006 16:50:24 +0200
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
In-Reply-To: <005501c6db44$102b73a0$294b82ce@stuartm>
Message-ID: <20060919145024.46580@gmx.net>
MIME-Version: 1.0
References: <005501c6db44$102b73a0$294b82ce@stuartm>
Subject: Re: TCP stack behaviour question
To: "Stuart MacDonald" <stuartm@connecttech.com>, ak@suse.de
X-Authenticated: #24879014
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps
> 
> Note that TCP has no error queue; MSG_ERRQUEUE is illegal on
> SOCK_STREAM sockets.  IP_RECVERR is valid for TCP, but all errors are
> returned by socket function return or SO_ERROR only.

Stuart -- thanks, added for man-pages-2.41.

Interestingly, at this point in the man pages source there
is the following commented out text:

.\" FIXME . Is it a good idea to document that? It is a dubious feature.
.\" On
.\" .B SOCK_STREAM
.\" sockets,
.\" .I IP_RECVERR
.\" has slightly different semantics. Instead of
.\" saving the errors for the next timeout, it passes all incoming
.\" errors immediately to the user.
.\" This might be useful for very short-lived TCP connections which
.\" need fast error handling. Use this option with care:
.\" it makes TCP unreliable
.\" by not allowing it to recover properly from routing
.\" shifts and other normal
.\" conditions and breaks the protocol specification.

Cheers,

Michael
-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
