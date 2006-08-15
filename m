Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965381AbWHOQVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbWHOQVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWHOQVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:21:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:27535 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965384AbWHOQVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:21:50 -0400
Date: Tue, 15 Aug 2006 18:21:45 +0200
From: Andi Kleen <ak@muc.de>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <patches@x86-64.org>, discuss@x86-64.org
Subject: Re: [PATCH] fix x86 cpuid keys used in alternative_smp()
Message-Id: <20060815182145.6dc74c63.ak@muc.de>
In-Reply-To: <44E20C5C.76E4.0078.0@novell.com>
References: <44E20C5C.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 18:03:08 +0200
"Jan Beulich" <jbeulich@novell.com> wrote:

> By hard-coding the cpuid keys for alternative_smp() rather than using
> the symbolic constant it turned out that incorrect values were used on
> both i386 (0x68 instead of 0x69) and x86-64 (0x66 instead of 0x68).

Thanks. Applied.

I wonder if that was the reason why the .fill misassembly the 
2.16.91.0.5 (10.1) binutils commits (see recent discuss report from
Rafael) didn't cause crashes on UP machines.  Do you have
an opinion on that?

-Andi
]
