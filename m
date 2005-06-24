Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbVFXG3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbVFXG3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVFXG3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:29:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30772
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S263177AbVFXG24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:28:56 -0400
Message-Id: <42BBC468020000780001D4B0@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 24 Jun 2005 08:29:28 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Keith Owens" <kaos@sgi.com>
Cc: "Clyde Griffin" <CGRIFFIN@novell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Keith Owens <kaos@sgi.com> 24.06.05 04:15:19 >>>
>On Thu, 23 Jun 2005 16:54:09 -0600, 
>"Clyde Griffin" <CGRIFFIN@novell.com> wrote:
>>
>>Novell engineering is introducing the Novell Linux Kernel Debugger
>>(NLKD) as an open source project intended to provide an enhanced and
>>robust debugging experience for Linux kernel developers.

>Hmm, no backtrace,

That's certainly wrong: for x86 it uses .eh_frame info, for ia64 it would use the native one.

>turns off kprobes,

A temporary measure; enabling this again is on the todo list.

>does not handle ia64 MCA/INIT.

It doesn't handle ia64 at all at present; the code in there is yet-to-be-ported code. Only x86{,-64} has been dealt with so far.

>And don't get me started about the trailing white space in the patch.

While I wasn't aware of any (and honestly, I hate discovering such, too), that is certainly the easiest thing to take care of.

>I'll stick with KDB for now.

Your choice, obviously.

Jan


