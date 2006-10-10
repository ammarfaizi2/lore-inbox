Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWJJF0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWJJF0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWJJF0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:26:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46781 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964986AbWJJF0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:26:44 -0400
Date: Mon, 9 Oct 2006 22:26:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Why is device_create_file __must_check?
Message-Id: <20061009222641.96c4acb5.akpm@osdl.org>
In-Reply-To: <17707.11292.661824.337474@cargo.ozlabs.ibm.com>
References: <17707.8801.395100.35054@cargo.ozlabs.ibm.com>
	<20061009214936.a2788702.akpm@osdl.org>
	<17707.11292.661824.337474@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 15:14:04 +1000
Paul Mackerras <paulus@samba.org> wrote:

> > Because it can fail.  We need to take _some_ action if the setup failed - at
> > least report it so the user (and the kernel developers) know that something
> > is going wrong.
> 
> So we have to add printks in all sorts of places where the
> device_create_file has never failed before.  If you're that concerned,

aren't you concerned too?

> why not add a WARN_ON(error) in device_create_file() ?

That might be suitable, yup.
