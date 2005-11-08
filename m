Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbVKHHgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVKHHgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKHHgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:36:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28867 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965070AbVKHHgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:36:21 -0500
Date: Tue, 8 Nov 2005 08:36:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 16/21] i386 Eliminate duplicate segment macros
Message-ID: <20051108073635.GF28201@elte.hu>
References: <200511080436.jA84aGvD009933@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080436.jA84aGvD009933@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> +#define get_desc_32bit(desc)	(((desc)->b >> 22) & 1)
> +#define get_desc_contents(desc)	(((desc)->b >> 10) & 3)
> +#define get_desc_writable(desc)	(((desc)->b >>  9) & 1)
> +#define get_desc_gran(desc)	(((desc)->b >> 23) & 1)
> +#define get_desc_present(desc)	(((desc)->b >> 15) & 1)
> +#define get_desc_usable(desc)	(((desc)->b >> 20) & 1)

naming nit: shouldnt they be 'desc_32bit()/desc_writable()/...'? No need 
for the get_ i think.

	Ingo
