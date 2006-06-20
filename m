Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965212AbWFTIqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbWFTIqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbWFTIqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:46:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47517 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965212AbWFTIqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:46:52 -0400
Date: Tue, 20 Jun 2006 01:40:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-Id: <20060620014027.eba58cb7.akpm@osdl.org>
In-Reply-To: <20060620082745.GA28092@sergelap>
References: <20060615144331.GB16046@sergelap.austin.ibm.com>
	<20060619201450.3434f72f.akpm@osdl.org>
	<20060620082745.GA28092@sergelap>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 03:27:45 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Ah, like so?

Nope.  kthread_bind() is supposed to be called by the thread creator,
before the thread is started.

The documentation for kthread_bind() is irritatingly hidden in the header
file.
