Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTEGSzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTEGSzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:55:20 -0400
Received: from siaag1ac.compuserve.com ([149.174.40.5]:33236 "EHLO
	siaag1ac.compuserve.com") by vger.kernel.org with ESMTP
	id S264193AbTEGSzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:55:19 -0400
Date: Wed, 7 May 2003 15:04:57 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: "arjanv@redhat.com" <arjanv@redhat.com>
Cc: Steffen Persvold <sp@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305071507_MC3-1-37CF-FE32@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Preloading libraries, ptracing init, patching g/libc, etc. are
>> obviously not the way to go.
>
> those obviously need to be implemented via the security subsystem (eg
> LSM). Hooks are obviously the wrong level to do things and I could even
> tell you that you cannot implement this right from a module actually.

  What is really needed is some kind of proper generic hooking setup
that could be used both by LSM and other things.  People doing this
may need to intercept syscalls both on their way to the kernel and 
on the way back to userland (so they can see return codes.)  They may
also need to say whether they want to be first or last if there are
multiple users of this facility.

  But the real question is why the export of sys_call_table was so
gratuitously removed without any kind of replacement being offered.
And the attitude of the developers about it is truly awful. ("Oh, so
we broke the drivers you depend on for your livelihood?  You can just
go get a new job -- pounding sand down a rathole.")


