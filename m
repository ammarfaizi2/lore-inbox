Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWHRWCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWHRWCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWHRWCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:02:31 -0400
Received: from xenotime.net ([66.160.160.81]:63723 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751502AbWHRWCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:02:30 -0400
Date: Fri, 18 Aug 2006 15:05:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-Id: <20060818150526.cc4318bb.rdunlap@xenotime.net>
In-Reply-To: <1155844419.6788.62.camel@localhost.localdomain>
References: <1155844419.6788.62.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:53:39 -0700 Kylene Jo Hall wrote:

> Documentation.

Here are a few comments for you.
I'll look for the updates as well.

> Documentation/slim.txt |   69 ++++++++++++++++++++++++++++++++++++++
> + 1 files changed, 69 insertions(+) 
> 
> --- linux-2.6.18/Documentation/slim.txt	1969-12-31
> 16:00:00.000000000 -0800 +++
> linux-2.6.18-rc4/Documentation/slim.txt	2006-08-17
> 12:38:24.000000000 -0700 @@ -0,0 +1,69 @@ 
> +SLIM is an LSM module which provides an enhanced low water-mark
> +integrity and high water-mark secrecy mandatory access control
> +model.
> +
> +SLIM now performs a generic revocation operation, including

Drop "now".

> revoking +mmap and shared memory access. Note that during demotion
> or promotion +of a process, SLIM needs only revoke write access to
> files with higher +integrity, or lower secrecy. Read and execute
> permissions are blocked +as needed, not revoked.  SLIM hopefully
> uses d_instantiate correctly now. +

Drop "now".

> +In normal operation, the system seems to stabilize with a roughly
> +equal mixture of SYSTEM, USER, and UNTRUSTED processes. Most
> +applications seem to do a fixed set of operations in a fixed
> domain, +and stabilize at their appropriate level. Some
> applications, like +firefox and evolution, which inherently deal
> with untrusted data, +immediately go to the UNTRUSTED level, which
> is where they belong. +In a couple of cases, including cups and
> Notes, the applications +did not handle their demotions well, as
> they occured well into their +startup. For these applications, we

occurred

> simply force them to start up +as UNTRUSTED, so demotion is not an
> issue. The one application +that does tend to get demoted over time
> are shells, such as bash.

s/application/application area/ or /application type/ ?

> +These are not problems, as new ones can
> be created with the +windowing system, or with su, as needed. To
> help with the associated +user interface issue, the user space
> package README shows how to +display the SLIM level in window
> titles, so it is always clear at +what level the process is
> currently running.

This is confusing to me.  What README?

> +As mentioned earlier, cupsd and notes are applications which are

Notes (as used earlier)

> +always run directly in untrusted mode, regardless of the level of
> +the invoking process.


---
~Randy
