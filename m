Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDOU1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUDOUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:25:47 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:56785 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262758AbUDOUY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:24:26 -0400
Message-ID: <407EEF6C.6030408@colorfullife.com>
Date: Thu, 15 Apr 2004 22:24:12 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mq_open() honor leading slash
References: <20040415113951.G21045@build.pdx.osdl.net>
In-Reply-To: <20040415113951.G21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>Patch below simply eats all leading slashes before passing name to
>lookup_one_len() in mq_open() and mq_unlink().
>  
>
Why should we do that in kernel space?
The kernel interface is "no slash at all". User space can add a SuS 
compatible layer on top of the kernel interface (i.e. fail with -EINVAL 
if the first character is not a /, then skip the slash and pass "name+1" 
to sys_mq_open()).

--
    Manfred

