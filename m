Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVKJATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVKJATE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVKJATE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:19:04 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:25160 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbVKJATD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:19:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JmkrwKzSwcHgOVdznW2YkKBQ/+No36EPVdBBKP6s2jk9jaOsdstptAF0XdXR8CfcTHBeQ6FnnprKXqNHZEm2RaV3DxkljzmLefYxQwmDkjcEkOam5ROhHRBV08IShamquPMTYIkH8EgsXb5cidPDAH2eCHNqVmb+M0FzKNCL4B0=
Message-ID: <625fc13d0511091619t135ec822t7f77aeb27e5db6f@mail.gmail.com>
Date: Wed, 9 Nov 2005 18:19:02 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: latest mtd changes broke collie
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, dwmw2@infradead.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051109221712.GA28385@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051109221712.GA28385@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/05, Pavel Machek <pavel@ucw.cz> wrote:
>
> Latest mtd changes break collie...it now oopses during boot. This
> reverts the bad patch.
>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
>
<snip>
> -               for(i=0;i<100;i++){
> -                       status = map_read32(map,adr);
> -                       if((status & SR_READY)==SR_READY)
> -                               break;
> -                       udelay(1);
> +               status = map_read32(map,adr);

I was just discussing with someone today how map_read32 no longer
exists in the kernel...  does this even compile for you?

Somehow I think I'm missing something...

josh
