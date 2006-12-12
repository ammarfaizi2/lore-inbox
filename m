Return-Path: <linux-kernel-owner+w=401wt.eu-S1751067AbWLLDlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWLLDlG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWLLDlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:41:06 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34142
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751067AbWLLDlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:41:03 -0500
Date: Mon, 11 Dec 2006 19:41:02 -0800 (PST)
Message-Id: <20061211.194102.74749040.davem@davemloft.net>
To: matthltc@us.ibm.com
Cc: zaitcev@redhat.com, erikj@sgi.com, guillaume.thouvenin@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: David Miller <davem@davemloft.net>
In-Reply-To: <1165892956.24721.129.camel@localhost.localdomain>
References: <20061211172907.305473cf.zaitcev@redhat.com>
	<20061211.175050.55478586.davem@davemloft.net>
	<1165892956.24721.129.camel@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Helsley <matthltc@us.ibm.com>
Date: Mon, 11 Dec 2006 19:09:16 -0800

> Hmm, that GCC assumption conflicts with the prototypes of memcpy() I've
> seen.

When GCC expands __builtin_memcpy() internally it looks at the types
of the arguments, and what it knows about their guarenteed alignment.

memcpy()'s declaration of the first argument as "void *" has
zero influence upon any of this.
