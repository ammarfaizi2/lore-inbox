Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTJIQiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTJIQiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:38:05 -0400
Received: from pat.uio.no ([129.240.130.16]:53196 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262283AbTJIQh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:37:59 -0400
To: Paul Mundt <lethal@linux-sh.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/clnt.c compile fix
References: <20031009161350.GA9170@linux-sh.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Oct 2003 12:37:49 -0400
In-Reply-To: <20031009161350.GA9170@linux-sh.org>
Message-ID: <shsr81mnz8i.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Mundt <lethal@linux-sh.org> writes:

     > Not sure if anyone has submitted this already, but as the
     > subject implies, net/sunrpc/clnt.c does not compile in either
     > stock test7 or in current BK:

Only if you do not also set CONFIG_SYSCTL.

     >   CC net/sunrpc/clnt.o net/sunrpc/clnt.c: In function
     >   `call_verify': net/sunrpc/clnt.c:965: structure has no member
     >   named `tk_pid' net/sunrpc/clnt.c:970: structure has no member
     >   named `tk_pid' net/sunrpc/clnt.c:976: structure has no member
     >   named `tk_pid' make[1]: *** [net/sunrpc/clnt.o] Error 1 make:
     >   *** [net/sunrpc/clnt.o] Error 2

     > This is due to the fact that tk_pid is protected by
     > RPC_DEBUG. Wrapping through dprintk() fixes this.

No... You are suppressing legitimate warning messages that inform the
user of a client/server mismatch!

Better then to remove the tk_pid from the warning messages...

Cheers
  Trond
