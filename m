Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVBPFwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVBPFwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVBPFwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:52:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:4570 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261996AbVBPFw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:52:29 -0500
Date: Tue, 15 Feb 2005 21:51:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
       nathanl@austin.ibm.com
Subject: Re: [PATCH] Run softirqs on proper processor on offline
Message-Id: <20050215215146.4c063baf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
References: <20050211232821.GA14499@otto>
	<Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
	<20050214215948.GA22304@otto>
	<20050215070217.GB13568@elte.hu>
	<20050216020628.GA25596@otto>
	<Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> Ensure that we only offline the processor when it's safe and never run 
>  softirqs in another processor's ksoftirqd context. This also gets rid of 
>  the warnings in ksoftirqd on cpu offline.

I don't get it.  ksoftirqd is pinned to its cpu, so why does any of this
matter?

