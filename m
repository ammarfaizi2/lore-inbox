Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVASGOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVASGOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 01:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVASGOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 01:14:42 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:14220 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261598AbVASGOl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 01:14:41 -0500
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: usbmon, usb core, ARM
Date: Tue, 18 Jan 2005 22:14:24 -0800
User-Agent: KMail/1.7.1
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com
References: <20050118212033.26e1b6f0@localhost.localdomain>
In-Reply-To: <20050118212033.26e1b6f0@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200501182214.25273.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 January 2005 9:20 pm, Pete Zaitcev wrote:
> 
> However, David objects to the patch on the grounds that it can damage ARM.

Actually what I said was:

> > Those patches were added for important reasons.  (Or did you add some
> > other solution to the issue described in that comment?)

which on closer examination (of just this patch, split out from all
the usbmon stuff) may well have been your cue to say something like
"my solution was to add a special case for root hubs into every urb's
giveback() path ... even though I left in the comment specifying that
this must be handled in the original way".

As well as:

> > Also, I don't like the idea of scattering knowledge all over the place
> > that the root hub is always given address 1 ... 

which you didn't address yet.

- Dave

