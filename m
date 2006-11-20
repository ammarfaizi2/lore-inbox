Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965918AbWKTPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965918AbWKTPuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 10:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965919AbWKTPuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 10:50:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34284 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965918AbWKTPuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 10:50:14 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4561CC0D.2070900@s5r6.in-berlin.de> 
References: <4561CC0D.2070900@s5r6.in-berlin.de>  <20061120142713.12685.97188.stgit@warthog.cambridge.redhat.com> <20061120142718.12685.84850.stgit@warthog.cambridge.redhat.com> 
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] WorkStruct: Typedef the work function prototype 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 20 Nov 2006 15:47:34 +0000
Message-ID: <14330.1164037654@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> > Define a type for the work function prototype.  It's not only kept in the
> > work_struct struct, it's also passed as an argument to several functions.
> 
> If so, it should certainly also be used in the declarations and
> definitions of the work functions.

Is this what you mean?:

	work_func_t do_my_work
	{
		...
	}

	DECLARE_WORK(my_work, do_my_work);

	void do_it(void)
	{
		schedule_work(&my_work);
	}

David
