Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVBCUwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVBCUwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVBCUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:52:12 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:35222 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262970AbVBCUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:52:03 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: ATI modules using the _syscall() macro for unexported syscalls (was: Re: Fw: Re: [patch 02/11] uml: fix compilation for missing headers)
Date: Thu, 3 Feb 2005 21:51:18 +0100
User-Agent: KMail/1.7.2
Cc: David Howells <dhowells@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <200501142206.24730.blaisorblade@yahoo.it> <30254.1105783030@redhat.com> <20050115020349.44a3622a.akpm@osdl.org>
In-Reply-To: <20050115020349.44a3622a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032151.18408.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 11:03, Andrew Morton wrote:
> David Howells <dhowells@redhat.com> wrote:
[....]
> I'm not sure that we even use errno any more.  The only syscall trap which
> the kernel internally takes now is execve().  Everything else is (or should
> be) just calling the sys_foo() function directly.

The ATI kernel modules reportedly use the syscall() facility to call 
modify_ldt, which I guess is not exported... I've received the report of this 
because that causes a name conflict with the SKAS patch I maintain.

Also, I have the doubt is that they're circumventing EXPORT_SYMBOL 
restrictions and thus violating the license. IANAL, however.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

