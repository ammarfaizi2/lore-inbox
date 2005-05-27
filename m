Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVE0THu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVE0THu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVE0THu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:07:50 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:27112 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262539AbVE0THh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:07:37 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42976D3A.5020200@davyandbeth.com>
References: <42975945.7040208@davyandbeth.com>
	 <1117217088.4957.24.camel@localhost.localdomain>
	 <42976D3A.5020200@davyandbeth.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 15:07:33 -0400
Message-Id: <1117220853.6477.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 13:55 -0500, Davy Durham wrote:
> Cool.. I looked at the daemon function and I might be able to use it..
> 
> However, I compiled your code... seems to work.. but where is the wait() 
> done on the middle parrent so that it isn't left defunct?

Sorry, forgot about that...
[...]

> >
> >/* parent code here */

waitpid(pid,&status,0);
	
/* and then you can look at WEXITSTATUS(status) to
   see if the second fork succeeded. */
if (WEXITSTATUS(status)) {
	/* failed */
} else {
	/* succeeded */
}

/* Here the second child and parent are now divorced */


-- Steve


