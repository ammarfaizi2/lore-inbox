Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUJ0Tgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUJ0Tgt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUJ0Tcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:32:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:49832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262650AbUJ0TUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:20:34 -0400
Date: Wed, 27 Oct 2004 12:20:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reserving a syscall number
Message-ID: <20041027122032.B14339@build.pdx.osdl.net>
References: <417FED6E.3010007@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <417FED6E.3010007@comcast.net>; from nigelenki@comcast.net on Wed, Oct 27, 2004 at 02:48:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Richard Moser (nigelenki@comcast.net) wrote:
> How would one go about having a specific syscall number reserved in
> entry.S?  I'm exploring doing a kill inside the kernel from a detection
> done in userspace, which would allow the executable header of the binary
> to indicate whether the task should be killed or not; if it works, the
> changes will likely not go into mainline, but will still require a
> non-changing syscall index (assuming I understood the syscall manpage
> properly).

To reserve a syscall there needs to be some users and some eventual hope
of merging.  The idea, btw, means anyone can specify the value in the
binary, so it could just as easily be done via prctl or something
similar that makes the out of tree patch easier to maintain.  Although,
I don't actually see the value with the description above.

> On a side note, if a syscall doesn't exist, how would that be detected
> in userspace?

ENOSYS error.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
