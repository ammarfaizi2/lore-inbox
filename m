Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTFKC6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTFKC6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:58:17 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:31894 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264047AbTFKC6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:58:17 -0400
Date: Tue, 10 Jun 2003 20:12:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, pbadari@us.ibm.com
Subject: Re: 2.5.70-mm6
Message-Id: <20030610201242.7fde819b.akpm@digeo.com>
In-Reply-To: <3EE690AC.70500@us.ibm.com>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	<3EE690AC.70500@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 03:11:59.0218 (UTC) FILETIME=[38AA2D20:01C32FC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> I run 50 fsx tests on ext3 filesystem on 2.5.70-mm6 kernel. Serveral fsx 
>  tests hang with the status D, after the tests run for a while.  No oops, 
>  no error messages.  I found same problem on mm5, but 2.5.70 is fine.
> 
>  Here is the stack info:

Thanks for this.

Everything is waiting on I/O.  It looks like either the device driver
failed or the IO scheduler got its state all screwed up.

Which device driver are you using there?

If you could, please retest with "elevator=deadline"?


