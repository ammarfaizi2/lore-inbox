Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932674AbVJCTt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVJCTt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbVJCTt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:49:27 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:53649 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932665AbVJCTt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:49:26 -0400
Date: Mon, 3 Oct 2005 12:49:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Erik Jacobson <erikj@sgi.com>, Matthew Helsley <matthltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, pagg@oss.sgi.com
Subject: Re: [PATCH 1/3] Process Notification / pnotify
Message-Id: <20051003124918.2a65ef41.pj@sgi.com>
In-Reply-To: <20051003184644.GA19106@sgi.com>
References: <20051003184644.GA19106@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... I notice with interest two notification patches posted in
the last few days to lkml:

  Matthew Helsley's Process Events Connector (posted 28 Sep 2005)
  Erik Jacobson's pnotify (posted 3 Oct 2005)

I suspect Matthew and Erik will both instantly hate me for asking, but
does it make sense to integrate these two?

If I understand these two proposals correctly:

    Helsley adds hooks in fork, exec, id change, and exit, to pass
    events to userspace.

    Jacobson adds hooks in fork, exec and exit, to pass events to
    kernel routines and loadable modules.

Perhaps, just brainstorming here, it would make sense for Halsley to
register with pnotify instead of adding his own hooks in parallel.
This presumes that pnotify is accepted into the kernel, and that
pnotify adds the id change hook that Helsley requires.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
