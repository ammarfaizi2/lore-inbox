Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUEKE46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUEKE46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 00:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUEKE46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 00:56:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:46280 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262029AbUEKE45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 00:56:57 -0400
Date: Mon, 10 May 2004 21:56:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rene.herman@keyaccess.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040510215626.6a5552f2.akpm@osdl.org>
In-Reply-To: <200405102352.24091.bzolnier@elka.pw.edu.pl>
References: <409F4944.4090501@keyaccess.nl>
	<200405102125.51947.bzolnier@elka.pw.edu.pl>
	<409FF068.30902@keyaccess.nl>
	<200405102352.24091.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> There is a problem with new 2.6 generic ->shutdown framework,
>  it doesn't differentiate between reboot / halt and power_off.
>  We may try to fix it or revert to 2.4 way of doing things if
>  this is too big change for 2.6.

It's a bit grubby, but we could easily add a fourth state to
`system_state': split SYSTEM_SHUTDOWN into SYSTEM_REBOOT and SYSTEM_HALT. 
That would be a quite simple change.

