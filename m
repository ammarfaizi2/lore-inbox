Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268748AbTGTWMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268755AbTGTWMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:12:53 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23562 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S268748AbTGTWMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:12:48 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels? 
In-reply-to: Your message of "Sun, 20 Jul 2003 06:31:37 MST."
             <20030720063137.3b0f2e14.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jul 2003 08:27:19 +1000
Message-ID: <7283.1058740039@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003 06:31:37 -0700, 
"David S. Miller" <davem@redhat.com> wrote:
>On Sun, 20 Jul 2003 22:55:18 +1000
>Keith Owens <kaos@ocs.com.au> wrote:
>
>> i386 provides no unwind data
>
>We could tell gcc to emit dwarf2 unwind tables on x86 for debugging
>kernel builds.

C code is not really an issue.  Most of the unwind complexity is
handling the special case asm code, interrupt handlers, out of line
lock contention paths, anything in entry.S.  Much of the IA64 asm code
has explicit unwind directives in the asm code, i386 asm would need
equivalent kernel changes.

