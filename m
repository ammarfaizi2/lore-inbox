Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422693AbWCWUxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWCWUxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWCWUxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:53:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9940 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422693AbWCWUxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:53:03 -0500
Date: Thu, 23 Mar 2006 12:52:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Murali <muralim@in.ibm.com>
Subject: Re: [RFC][PATCH 1/10] 64 bit resources core changes
In-Reply-To: <1143145335.3147.52.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0603231250410.26286@g5.osdl.org>
References: <20060323195752.GD7175@in.ibm.com>  <20060323195944.GE7175@in.ibm.com>
 <1143145335.3147.52.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Mar 2006, Arjan van de Ven wrote:
> 
> hmmmm are there any platforms where unsigned long long is > 64 bits?
> (and yes it would be nice if there was a u64 printf flag ;)

Adding a new printf flag is technically _trivial_.

The problem is getting gcc not to warn about it every time it sees it 
(while not losing the gcc format string checking entirely). Do newer gcc's 
allow some way of saying "this flag takes this type" for extended format 
definitions?

		Linus
