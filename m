Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUKSEsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUKSEsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUKSEsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:48:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:2030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261252AbUKSEsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:48:52 -0500
Date: Thu, 18 Nov 2004 20:48:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       Anton Blanchard <anton@samba.org>
Subject: Re: Six archs are missing atomic_inc_return()
Message-Id: <20041118204836.09d2d738.akpm@osdl.org>
In-Reply-To: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
References: <200411180148_MC3-1-8EE2-A85D@compuserve.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
>  Six archs do not have the atomic_inc_return() macro as of 2.6.10-rc2:
> 
>    cris
>    h8300
>    m32r
>    ppc
>    ppc64
>    s390

All of these architectures implement atomic_add_return().  So they all need

	#define atomic_inc_return(v)	atomic_add_return(1, v)

added to their atomic.h.

Wanna send a patch?
