Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269026AbTGJHrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269034AbTGJHrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:47:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269026AbTGJHq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 03:46:58 -0400
Date: Thu, 10 Jul 2003 00:56:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: rmk@arm.linux.org.uk, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: 2.5.74-mm3 yenta-socket oops back
Message-Id: <20030710005610.62dfa7ef.akpm@osdl.org>
In-Reply-To: <200307101448.58180.mflt1@micrologica.com.hk>
References: <200307060039.34263.daniel.ritz@gmx.ch>
	<200307101127.32590.mflt1@micrologica.com.hk>
	<20030709213010.1882a898.akpm@osdl.org>
	<200307101448.58180.mflt1@micrologica.com.hk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mflt1@micrologica.com.hk> wrote:
>
> Is called from interrupt handler. Seems that events occur before the 
>  thread is created.

OK, fair enough.  The interrupt probe happens before the socket
registration.   It needs a /* comment */


