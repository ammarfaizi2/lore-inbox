Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVJZPXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVJZPXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVJZPXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:23:16 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:64207 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964778AbVJZPXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:23:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jiIYq+T5lsbMKxxk/+iWTijBnR3hUsWr3kdS7uFGdye44u70StpferTZiPv2MoMYhwND/CYuMPVtgzWpQBlRTR5dWB0+cNtCA/DFNGLCPPmbblaLNk0//B8HsrppbLPeO2Mibu607C9KPqubP30mHNqCfXIerEYW+/a9C5dwHOM=
Message-ID: <9a8748490510260823s681a4d82k5efa5734486eda85@mail.gmail.com>
Date: Wed, 26 Oct 2005 17:23:14 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] kill massive wireless-related log spam
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200510261704.15366.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026042827.GA22836@havoc.gtf.org>
	 <200510261704.15366.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Andi Kleen <ak@suse.de> wrote:
> On Wednesday 26 October 2005 06:28, Jeff Garzik wrote:
>
> > Change this to printing out the message once, per kernel boot.
>
> It doesn't do that. It prints it once every 2^32 calls. Also

I noted that as well. How about just using something along the lines of

static unsigned char printed_message = 0;
if (!printed_message) {
    printk(...);
    printed_message++;
}


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
