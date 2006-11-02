Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752616AbWKBA2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbWKBA2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbWKBA2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:28:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752616AbWKBA2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:28:37 -0500
Date: Wed, 1 Nov 2006 16:27:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Neil Horman" <nhorman@tuxdriver.com>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
 several drivers
Message-Id: <20061101162727.72f1183b.akpm@osdl.org>
In-Reply-To: <20061101161155.d7b30258.randy.dunlap@oracle.com>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	<1161660875.10524.535.camel@localhost.localdomain>
	<20061024125306.GA1608@hmsreliant.homelinux.net>
	<1161729762.10524.660.camel@localhost.localdomain>
	<20061101135619.GA3459@hmsreliant.homelinux.net>
	<9a8748490611011605u55ccdcaeob99700d6e1a813a4@mail.gmail.com>
	<20061101161155.d7b30258.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 16:11:55 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> > Hmm, I guess that should be defined once and for all in
> > Documentation/CodingStyle
> 
> I have some other CodingStyle changes to submit, but feel free
> to write this one up.

Starting labels in column 2 gives me the creeps, personally.  But there's a
decent justification for it.

> However, I didn't know that we had a known style for this, other
> than "not indented so far that it's hidden".
> 
> If a label in column 0 [0-based :] confuses patch, then that's
> a reason, I suppose.  I wasn't aware of that one...
> In a case like that, we usually say "fix the tool then."

The problem is that `diff -p' screws up and displays the label: in the
place where it should be displaying the function name.

Of course, lots of people forget the -p anyway...  Maybe we can fix those
tools ;)
