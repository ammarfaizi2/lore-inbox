Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUATPlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUATPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:41:36 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34520 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265584AbUATPlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:41:32 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Date: Tue, 20 Jan 2004 16:45:48 +0100
User-Agent: KMail/1.5.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040120020710.837CE2C226@lists.samba.org>
In-Reply-To: <20040120020710.837CE2C226@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401201645.48611.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 of January 2004 03:01, Rusty Russell wrote:
> In message <200401171422.06211.bzolnier@elka.pw.edu.pl> you write:
> > +static int __init ide_generic_init(void)
> > +{
> > +	MOD_INC_USE_COUNT;
> > +	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
> > +		ide_get_lock(NULL, NULL); /* for atari only */
> > +
> > +	(void)ideprobe_init();
> > +
> > +	if (ide_hwifs[0].io_ports[IDE_DATA_OFFSET])
> > +		ide_release_lock();	/* for atari only */
> > +
> > +#ifdef CONFIG_PROC_FS
> > +	create_proc_ide_interfaces();
> > +#endif
> > +	return 0;
> > +}
> > +
> > +static void __exit ide_generic_exit(void)
> > +{
> > +}
>
> If you don't want to be unloadable, just don't have a module_exit() at
> all.

Ok, I will update it later.  Thanks for a hint!
--bart

