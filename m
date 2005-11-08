Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVKHHqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVKHHqe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKHHqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:46:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1920 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964887AbVKHHqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:46:34 -0500
Date: Tue, 8 Nov 2005 08:46:48 +0100
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
Subject: Re: [PATCH 21/21] i386 Ldt context inline
Message-ID: <20051108074648.GH28201@elte.hu>
References: <200511080442.jA84g2vH009964@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511080442.jA84g2vH009964@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> +	if (old_mm && unlikely(old_mm->context.ldt)) {
> +		retval = copy_ldt(&mm->context, &old_mm->context);
> +	}

style police: remove the { }. You only moved the function, but still :-)

	Ingo
