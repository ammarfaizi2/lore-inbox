Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWAIR54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWAIR54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWAIR54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:57:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030222AbWAIR5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:57:55 -0500
Date: Mon, 9 Jan 2006 12:57:48 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060109175748.GD25102@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060107052221.61d0b600.akpm@osdl.org> <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com> <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 06:47:01PM +0100, Jesper Juhl wrote:

 > Here's what bad_page printed for me :
 > 
 > Bad page state in process 'kded'
 > [<c0103e77>] dump_stack+0x17/0x20
 > [<c0148999>] bad_page+0x69/0x160

Odd, there should be more state between the 'Bad page'
and the backtrace.

    printk(KERN_EMERG "Bad page state in process '%s'\n"
		"page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
		"Trying to fix it up, but a reboot is needed\n"

Did you aggressively trim that, or did it for some
reason not get printed ?
 
		Dave

