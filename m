Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWDGJjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWDGJjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 05:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWDGJju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 05:39:50 -0400
Received: from sainfoin.extra.cea.fr ([132.166.172.103]:53635 "EHLO
	sainfoin.extra.cea.fr") by vger.kernel.org with ESMTP
	id S932401AbWDGJju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 05:39:50 -0400
Message-ID: <44363359.9010707@cea.fr>
Date: Fri, 07 Apr 2006 11:39:37 +0200
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
References: <200604061416.00741.Serge.Noiraud@bull.net> <443526B6.6090709@cea.fr> <200604061710.28293.Serge.Noiraud@bull.net>
In-Reply-To: <200604061710.28293.Serge.Noiraud@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> I know this. We need to use the mptspi module.
> I need to add "--with mptspi" to the mkinitrd command
> and that works correctly without the RT patch.

The problem is not that the mptspi module is missing. It is correctly 
inserted in the initrd. The problem is whichever order I set in the 
initrd concerning the module loading, I always got an symbol errors.
And what is really strange is that the 'sleep 1' solved the error...

I was wondering if this is not linked to hardware probe issue. It seems 
the kernel need few seconds to correctly initialize each module, and if 
another module is loaded at the same time, this hangs.
Very strange...

-- 
Aurelien Degremont

