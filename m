Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWESCXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWESCXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWESCXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:23:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:61901 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932180AbWESCXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MObCSty5XVsjsYsjxVCuPj0UT8Mq/d9zSyQfklkcTpXZyOVO0kSJm/EuExNF50xhBSzcDoL0u4WIqyWwweaJlOLTrIpJf5tKZZ3QNhgHVaYoDgVIH6TXaSTh2rEefonruxfG2DzHx7fsEWdXm9ESmFME8fiWnFDKudaAFGUUdWM=
Message-ID: <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com>
Date: Thu, 18 May 2006 19:23:13 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Renzo Davoli" <renzo@cs.unibo.it>
Subject: Re: [PATCH] 2-ptrace_multi
Cc: "Andi Kleen" <ak@suse.de>, osd@cs.unibo.it, linux-kernel@vger.kernel.org
In-Reply-To: <20060518211321.GC6806@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060518155337.GA17498@cs.unibo.it>
	 <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de>
	 <20060518211321.GC6806@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/06, Renzo Davoli <renzo@cs.unibo.it> wrote:
> e.g. To virtualize a write you'd have to call PTRACE_PEEKDATA for each
> word of the buffer, very many hundreds cycles lost.

No, this is not how programs should do it.  Just open /proc/PID/mem
and use pread() with an offset corresponding to the address.  Now,
repeat your timings using this technique.
