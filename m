Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUBFJF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBFJF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:05:57 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58024 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265105AbUBFJFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:05:35 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16419.22749.486759.348150@laputa.namesys.com>
Date: Fri, 6 Feb 2004 12:05:33 +0300
To: Micha Feigin <michf@post.tau.ac.il>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs - difference between a commit and a transaction
In-Reply-To: <20040206002346.GA2571@luna.mooo.com>
References: <20040206002346.GA2571@luna.mooo.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin writes:
 > I am trying to do some work on reiserfs to make it laptop-mode
 > compliant. After looking at the code because it was still noisy after I
 > thought I told correctly to be quite, raised a question that I was
 > hoping someone can clarify for me.
 > 
 > Reiserfs has both a transaction and a commit and I was wondering what
 > is which.

Transaction is a sequence of file system modifications that (by the
virtue of file system implementation) is bound to either be completed as
a whole or be aborted as a whole (this is called "atomicity").

Commit is a certain operation performed during transaction life-time to
implement its atomicity.

 > 
 > (I am mostly interested in this from the point of what max_trans_age
 > and max_commit_age affect)

Take a look at the "commit" mount option of reiserfs.

 > 
 > Thanks

Nikita.
