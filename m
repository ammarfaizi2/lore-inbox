Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUIXPY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUIXPY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 11:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268836AbUIXPY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 11:24:59 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17839
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S268839AbUIXPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 11:24:49 -0400
Message-Id: <s1544a4f.030@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Fri, 24 Sep 2004 17:25:35 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 entry.S problems
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Arjan van de Ven <arjanv@redhat.com> 24.09.04 16:57:08 >>>
>On Fri, 2004-09-24 at 16:12, Jan Beulich wrote:
>> There appear to be two problems in i386's entry.S:
>> 
>> (1) With CONFIG_REGPARM, lcall7 and lcall27 did not work (they pass
the
>> parameters to the actual handler procedure on the stack).
>
>I wonder why we still have the lcall7/lcall27 entry points in the
>kernel; nothing can legitemately use them and in the last few years
they
>have only caused a few security issues. Can I ask why you didn't just
>remove this code from the kernel ?

I wondered about this, too. But I assumed that somewhere something
might live that still uses it. Since I don't know (and I found the entry
useful for some other test I had to do), I didn't dare to...

Jan
