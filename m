Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266354AbUBFAGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266948AbUBFAGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:06:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:48309 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266354AbUBFAGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:06:34 -0500
Date: Thu, 5 Feb 2004 16:07:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-aio@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat" DIO read race still fails
Message-Id: <20040205160755.25583627.akpm@osdl.org>
In-Reply-To: <1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
References: <20040205014405.5a2cf529.akpm@osdl.org>
	<1076023899.7182.97.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Andrew,
> 
> I tested 2.6.2-mm1 on an 8-proc running 6 copies of the read_under
> test and all 6 read_under tests saw uninitialized data in less than 5
> minutes. :(

The performance implications of synchronising behind kjournald writes for
normal non-blocking writeback are bad.  Can you detail what you now think
is the failure mechanism?


