Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293452AbSCARnV>; Fri, 1 Mar 2002 12:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSCARnL>; Fri, 1 Mar 2002 12:43:11 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:51965 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293452AbSCARnD>; Fri, 1 Mar 2002 12:43:03 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <23167.1015004426@warthog.cambridge.redhat.com> 
In-Reply-To: <23167.1015004426@warthog.cambridge.redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, davem@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 17:43:00 +0000
Message-ID: <6844.1015004580@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dhowells@redhat.com said:
>  Maybe you should return the old mask too?

rpc_clnt_sigmask() looks like it could do with that, yes. I note that uses 
spin_lock_irqsave() not spin_lock_irq() too - do they really call it with 
interrupts already disabled? Should we do the same?

--
dwmw2


