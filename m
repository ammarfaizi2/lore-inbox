Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbTDIJWF (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbTDIJWF (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:22:05 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:46300 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262961AbTDIJWE (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:22:04 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: Matti Aarnio <matti.aarnio@zmailer.org>, Frank Davis <fdavis@si.rr.com>
Subject: Re: kernel support for non-english user messages
Date: Wed, 9 Apr 2003 11:33:40 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org>
In-Reply-To: <20030409080803.GC29167@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304091133.40974.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. April 2003 10:08 schrieb Matti Aarnio:
> On Wed, Apr 09, 2003 at 01:02:16AM -0400, Frank Davis wrote:
> > All,
> >
> > I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and
> > 2.5.x, I believe) that I believe would be helpful. Currently, printk
> > messages are all in english, and I was wondering if printk could be
> > modified to print out user messages that are in the default language of
> > the machine. For example,
>
> To propagate the idea further, why not have proper message catalogs,
>
> and that way translations.  Instead of:
> > printk(KERN_WARN "This driver is messed up!\n");
>
> There would be:
>   printk(KERN_WARN "1234-6789 this driver is messed up!\n")
>
> In the old days of big iron beasts, there used to be multivolume
> binders full of system messages, and their explanations.
> Searching went thru those "1234-5678" strings.
>
> There were sets of those manuals in a number of customer languages.

If we do this, why not go the whole way?
Could we compute a hash value for every message that's not KERN_CRIT,
use it to create a table of messages and hashes and replace the messages
in the kernel image with the hash values leaving expansion to klogd?

	Regards
		Oliver

