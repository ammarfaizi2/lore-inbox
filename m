Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSHAUHE>; Thu, 1 Aug 2002 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSHAUHE>; Thu, 1 Aug 2002 16:07:04 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55027 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316897AbSHAUHD>; Thu, 1 Aug 2002 16:07:03 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208011203010.3000-100000@penguin.transmeta.com> 
References: <Pine.LNX.4.33.0208011203010.3000-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Aug 2002 21:10:28 +0100
Message-ID: <10545.1028232628@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  They should be waiting in TASK_UNINTERRUPTIBLE, and we should add a
> flag  to distinguish between "increases load average" and "doesn't".

The disadvantage of this approach is that it encourages people to be lazy
and sleep with signals disabled, instead of implementing proper cleanup
code. 

I'm more in favour of removing TASK_UNINTERRUPTIBLE entirely, or at least 
making people apply for a special licence to be permitted to use it :)

--
dwmw2


