Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVAQN37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVAQN37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAQN36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:29:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64135 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262787AbVAQN2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:28:11 -0500
Subject: Re: [PATCH] Restartable poll(2)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Naoaki Maeda <maeda.naoaki@jp.fujitsu.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050117.113142.41643336.maeda.naoaki@jp.fujitsu.com>
References: <20050114.205214.74752151.maeda.naoaki@jp.fujitsu.com>
	 <20050117.113142.41643336.maeda.naoaki@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105963410.12709.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 17 Jan 2005 12:23:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-17 at 02:31, Naoaki Maeda wrote:
> Hi,
> 
> Does nobody think a system call is interrupted by SIGSTOP is
> strange behaviour?

Not really

> According to the man page, both of poll(2) and select(2) can be
> interrupted by signals, but select(2) interrupted by SIGSTOP is
> automatically restarted, and poll(2) isn't. 

Correct - select and poll come from different worlds with different
viewpoints on signal behaviour.

> If it is a specification of Linux, using job control or ptrace()
> isn't safe because it changes the behaviour of target programs.

Programs must always deal with system call -EINTR responses
appropriately.

