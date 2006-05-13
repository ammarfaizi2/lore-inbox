Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWEML14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWEML14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWEML14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:27:56 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:5176 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S932382AbWEML1z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:27:55 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Douglas McNaught <doug@mcnaught.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <87r72yi346.fsf@suzuka.mcnaught.org>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
	<87r72yi346.fsf@suzuka.mcnaught.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513112754.1CA99146AF@hunin.borkware.net>
Date: Sat, 13 May 2006 13:27:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas McNaught <doug@mcnaught.org> wrote:
> It needs to be readable as well.  What ends up happening is that the
> kernel sees the execute bit, looks at the shebang line and then does:
> 
> /bin/sh test
> 
> Since read permission is off, the shell's open() call fails.  It will
> work fine if you use 755 as the permissions.
> 
> Every Unix I've ever seen works this way.  It'd be nice to have
> unreadable executable scripts, but no one's ever done it.

According to
http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html both 4.3BSD
and SunOS have. I can confirm that it works on current BSD's as
well.
