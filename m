Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTEaRpS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264555AbTEaRpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:45:18 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:21826 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264549AbTEaRpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:45:17 -0400
Date: Sat, 31 May 2003 10:58:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush -> noflushd related question
Message-Id: <20030531105850.7cc92601.akpm@digeo.com>
In-Reply-To: <200305311841.59599.fsdeveloper@yahoo.de>
References: <200305311841.59599.fsdeveloper@yahoo.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 May 2003 17:58:39.0195 (UTC) FILETIME=[43C732B0:01C3279E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <fsdeveloper@yahoo.de> wrote:
>
>  So, how to set the interval, or better sayed, how to _stop_
>  buffer flushing in 2.5?

/proc/sys/vm has the appropriate tunables.  They are documented in
Documentation/filesystems/proc.txt.

You can turn these guys off by setting the sysctls to 1000000000
I guess.   Problem is, I don't think there's a way of starting them
again until the ten million seconds expires.  hmm.
