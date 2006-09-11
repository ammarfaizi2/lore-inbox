Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWIKAyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWIKAyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWIKAyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:54:36 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41382 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S964862AbWIKAyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:54:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAP5QBEWBTol4LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp problem
Date: Sun, 10 Sep 2006 20:54:33 -0400
User-Agent: KMail/1.9.3
Cc: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org> <20060910194955.GA1841@elf.ucw.cz>
In-Reply-To: <20060910194955.GA1841@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609102054.34350.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 15:49, Pavel Machek wrote:
> Hi!
> 
> > >What kind of machine is that? What cpu? Really 486?
> > 
> > yes, it's viglen dossier 486 based laptop .
> 
> Forget it, this thing does not support 4MB pages, and swsusp currently
> needs them. (We'll need to fix that, but not now -- fix is port of
> page-table handling code from x86-64).
> 
> It should die with
> 
>         if (!cpu_has_pse) {
>                 printk(KERN_ERR "PSE is required for swsusp.\n");
>                 return -EPERM;
>         }
> 
> ...can you investigate why it does not?
> 

Probably because of this:

> > flags : fpu vme pse
                    ^^^

> > bogomips : 31.55
> 

-- 
Dmitry
