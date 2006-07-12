Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWGLWMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWGLWMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGLWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:12:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:3037 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751288AbWGLWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:12:03 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Date: Wed, 12 Jul 2006 23:57:48 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Adrian Bunk <bunk@stusta.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, andrea <andrea@cpushare.com>
References: <200607121739_MC3-1-C4D3-28B9@compuserve.com>
In-Reply-To: <200607121739_MC3-1-C4D3-28B9@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607122357.48045.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We can just fold the TSC disable stuff into the new thread_flags test
> at context-switch time:

I don't think it will work because you need to check state of 
both previous and next task. The thread_flags test only checks the
state of the next task.

-Andi

