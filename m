Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbTDAAfw>; Mon, 31 Mar 2003 19:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTDAAfw>; Mon, 31 Mar 2003 19:35:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22545 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261947AbTDAAfv>;
	Mon, 31 Mar 2003 19:35:51 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Put all functions in kallsyms 
In-reply-to: Your message of "Mon, 31 Mar 2003 18:14:03 +1000."
             <20030331224033.489DD2C04B@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Apr 2003 10:46:54 +1000
Message-ID: <6572.1049158014@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003 18:14:03 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>D: TODO: Allow multiple kallsym tables, discard init one after init.

Don't.  Almost all kernel threads have a backtrace that goes through
__init code, even though that code no longer exists.  The symbols are
still needed to get a decent backtrace and the overhead is minimal.

