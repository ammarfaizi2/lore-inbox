Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTJDGbX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 02:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJDGbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 02:31:23 -0400
Received: from codepoet.org ([166.70.99.138]:39602 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S261909AbTJDGbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 02:31:21 -0400
Date: Sat, 4 Oct 2003 00:31:15 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rob Landley <rob@landley.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Andries Brouwer <aebr@win.tue.nl>, Andries.Brouwer@cwi.nl,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Message-ID: <20031004063114.GA18876@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rob Landley <rob@landley.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andries Brouwer <aebr@win.tue.nl>, Andries.Brouwer@cwi.nl,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> <20031002153301.GA2033@win.tue.nl> <m13ceahix8.fsf@ebiederm.dsl.xmission.com> <200310032237.03431.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310032237.03431.rob@landley.net>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 03, 2003 at 10:37:03PM -0500, Rob Landley wrote:
> > My point is that we need to cleanly handle the fact that glibc
> > defines it's own abi that is not equivalent to the kernel abi.
> > A linux specific namespace does that.  After libc is done with
> > the definitions users will still use MS_RDONLY.
> 
> Does anything other than glibc have this problem?  (Does uclibc have this 
> problem?  cdrecord?)

glibc presents the glibc ABI to its client applications, and
uclibc presents the uclibc ABI to its clients.  If they choose to
process things a bit before communicating with their clients that
is their business.  But that is certainly not a problem for the
kernel developer's to worry about.

The means by which the various C libs present their own ABI to
their clients is also their private business.  If the kernel
developers can provide a clean ABI to user space that is not
mingled with kernel internals, you can be sure the various C lib
developers will be overjoyed to use that for kernel communication
and will gladly address any needed ABI translation.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
