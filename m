Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTJIQuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTJIQuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:50:37 -0400
Received: from pat.uio.no ([129.240.130.16]:63451 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262301AbTJIQug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:50:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.37335.822076.188805@charged.uio.no>
Date: Thu, 9 Oct 2003 12:50:31 -0400
To: Paul Mundt <lethal@linux-sh.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/clnt.c compile fix
In-Reply-To: <20031009164048.GA12029@linux-sh.org>
References: <20031009161350.GA9170@linux-sh.org>
	<shsr81mnz8i.fsf@charged.uio.no>
	<20031009164048.GA12029@linux-sh.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Mundt <lethal@linux-sh.org> writes:

     > Is there any reason why tk_pid needs to be under RPC_DEBUG in
     > the first place?  If these are legitimate warning messages,
     > presumably it would be nice to know the offending pid as well.

It's not a true process pid, but more of a tag on each struct
rpc_task. It turns out to be more helpful when you are tracing the
(d|)printk() debugging info, since a process may have several rpc_task
in flight at any point in time.

Cheers,
  Trond
