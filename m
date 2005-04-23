Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVDWC5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVDWC5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 22:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVDWC5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 22:57:06 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:6709 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261464AbVDWC5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 22:57:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WvajKPNoHzU1BhEd71WC4j/1kQ3d9XPOzDmDhSzZXB/yUlRaibNG5MjUox1i8UzjOuwuEd53NFa0EUFopVDFATlb2DIBxIbXuWckT28H/0ps83Y/muq1xGNAMRVnL2KUERqh5erb+tIOh3236VC9W2HwR4Agphh85ZUdInTDYjE=
Message-ID: <d120d500050422195755c5b918@mail.gmail.com>
Date: Fri, 22 Apr 2005 21:57:03 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stefan Seyfried <seife@suse.de>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Steinmetz <ast@domdv.de>
In-Reply-To: <42691498.7060003@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
	 <4267DC2E.9030102@domdv.de> <20050421185717.GB475@openzaurus.ucw.cz>
	 <42691498.7060003@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/05, Stefan Seyfried <seife@suse.de> wrote:
> --- linux/kernel/power/swsusp.c~        2005-04-22 17:07:56.000000000 +0200
> +++ linux/kernel/power/swsusp.c 2005-04-22 17:09:22.000000000 +0200
> @@ -1239,7 +1239,7 @@ static int check_sig(void)
>                 */
>                error = bio_write_page(0, &swsusp_header);
>        } else {
> -               printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
> +               printk(KERN_ERR "swsusp: Suspend partition is no suspend image.\n");

Hrm, I don't think it is a good message... What about "Suspend
partition has no suspend image" or, better yet, "Suspend partition
does not contain valid suspend image"?

-- 
Dmitry
