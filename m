Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUC2EHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUC2EHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:07:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:3968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262599AbUC2EHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:07:13 -0500
Date: Sun, 28 Mar 2004 20:07:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
Message-Id: <20040328200710.66a4ae1a.akpm@osdl.org>
In-Reply-To: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hartmann <andihartmann@freenet.de> wrote:
>
> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
>  kernel 2.6 seems to be slower than 2.4.25.
> 
>  So I did some tests to compare the performance directly. Therefore I
>  rebooted for everey test in init 2 (no X).
> 
>  I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
>  reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
>  the following result:
> 
>  In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
>  under 2.4.25.
>  The user-processortime is about the same, but the system-processortime is
>  under 2.6.4 32.9% higher than under 2.4.25.

Try mounting your reiserfs filesystems with the `-o nolargeio=1' option.

If that doesn't help, please run a comparative kernel profile.  See
Documentation/basic_profiling.txt.

Thanks.
