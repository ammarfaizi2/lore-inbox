Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWBMXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWBMXVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWBMXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:21:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964883AbWBMXVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:21:22 -0500
Date: Mon, 13 Feb 2006 15:20:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NLM: Fix the NLM_GRANTED callback checks
Message-Id: <20060213152021.6e25e40b.akpm@osdl.org>
In-Reply-To: <1139801149.7916.11.camel@lade.trondhjem.org>
References: <1139801149.7916.11.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
>
> Currently when the NLM_GRANTED callback comes in, lockd walks the list of
> blocked locks in search of a match to the lock that the NLM server has
> granted. Although it checks the lock pid, start and end, it fails to check
> the filehandle and the server address.
> 

What are the consequences of this bug?
