Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTJNJ3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJNJ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:29:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43663 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262280AbTJNJ3Q
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 14 Oct 2003 05:29:16 -0400
Date: Tue, 14 Oct 2003 10:29:09 +0100
From: Jamie Lokier <jamie@shareable.org>
To: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-ID: <20031014092909.GB24812@mail.shareable.org>
References: <JIEIIHMANOCFHDAAHBHOMEMEDAAA.alex_a@caltech.edu> <3F8B9324.8020005@namesys.com> <20031014064924.GP15809@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014064924.GP15809@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz wrote:
> Of course if i had designed it in the first place with the
> filesystem semantics that we have now there might be no
> rename system call.  Renames would be done by link(oldpath,
> newpath); unlink(oldpath);  A sequence that would cause
> ctime to change as a result of nlink changes.  A sequence
> that might be appropriate in some cases even inside the
> filesystem code.

Once upon a time, that's how renames were always done.

The rename() system call was added because (a) it provides the
additional atomicity semantic, which link+unlink does not; (b) it is
useful to allow directory renames, but directory hard links are
dangerous so not allowed any more.

-- Jamie
