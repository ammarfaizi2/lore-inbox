Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUDNEse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbUDNEse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:48:34 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:30390 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263871AbUDNEsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:48:33 -0400
Message-ID: <407CC26D.6070307@colorfullife.com>
Date: Wed, 14 Apr 2004 06:47:41 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mq_open() and close_on_exec?
References: <20040413174005.Q22989@build.pdx.osdl.net>
In-Reply-To: <20040413174005.Q22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>SUSv3 doesn't seem to specify one way or the other.  I don't have the
>POSIX specs, and the old docs I have suggest that mq_open() creates an
>object which is to be closed upon exec.  Anyone have a clue if this is
>actually required?  Patch below sets this as default (if indeed it's
>valid/required).
>  
>
Did you test what other unices do? I think the patch is correct - at 
least solaris implements message queues in user space, and then an exec 
should close everything.

--
    Manfred

