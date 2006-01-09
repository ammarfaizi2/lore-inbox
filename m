Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWAIOW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWAIOW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWAIOW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:22:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:665 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964770AbWAIOWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:22:55 -0500
Subject: Re: setrlimit for RLIMIT_RSS not enforced
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <728201270601041329r64ee9fb5h3ff015533c762924@mail.gmail.com>
References: <728201270601041329r64ee9fb5h3ff015533c762924@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 14:25:47 +0000
Message-Id: <1136816747.6659.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-04 at 15:29 -0600, Ram Gupta wrote:
> I am wondering why setrlimit for RLIMIT_RSS is  not enforced? Is 
> there any particular reason for not implementing it? Is there any
> taker if I implement it & submit patch for it?


I had a long long dig back through my mail archive in search of
RLIMIT_RSS. The original mm for Linux didn't enforce it as it did not
have any way to track RSS that was not computationally expensive. The
current mm is probably capable of implementing RSS limits although
questions then still remain about what effect this has if a user sets a
low RSS limit and then causes a lot of swap thrashing. 

If you can see a way to implement it efficiently then go for it.

Alan

