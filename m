Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130542AbRBWWLx>; Fri, 23 Feb 2001 17:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130597AbRBWWLn>; Fri, 23 Feb 2001 17:11:43 -0500
Received: from cc600749-a.hwrd1.md.home.com ([65.1.217.252]:4025 "EHLO
	entheal.com") by vger.kernel.org with ESMTP id <S130542AbRBWWLf>;
	Fri, 23 Feb 2001 17:11:35 -0500
Message-ID: <3A96E014.AFBD4859@entheal.com>
Date: Fri, 23 Feb 2001 17:11:32 -0500
From: Jacob L E Blain Christen <dweomer@entheal.com>
Reply-To: jacob.blain.christen@entheal.com
Organization: Entheal LLC
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Sourav Ghosh <sourav@cs.cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: creation of sock
In-Reply-To: <3A96C858.5C8FB714@cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looking further at 
net/ipv4/tcp_ipv4.c:tcp_create_openreq_child() (for 2.2.16)
and
net/ipv4/tcp_minisocks.c:tcp_create_openreq_child() (for 2.4.x)

immediately after the sk_alloc() call (if it successful) it calls
	memcpy(newsk, sk, sizeof(*newsk))
i suggest setting your NULL initial values immediately after this line.

sorry for the premature email
