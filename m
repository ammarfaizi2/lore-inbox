Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWJLIVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWJLIVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWJLIVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:21:12 -0400
Received: from matups.math.u-psud.fr ([129.175.50.4]:11229 "EHLO
	matups.math.u-psud.fr") by vger.kernel.org with ESMTP
	id S1422817AbWJLIVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:21:10 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] usbmon: add binary interface
Date: Thu, 12 Oct 2006 10:17:52 +0200
User-Agent: KMail/1.9.5
Cc: Pete Zaitcev <zaitcev@redhat.com>, Pavel Machek <pavel@suse.cz>,
       gregkh@suse.de, Paolo Abeni <paolo.abeni@email.it>,
       linux-kernel@vger.kernel.org
References: <1160557065.9547.12.camel@localhost.localdomain> <20061011194443.GA3935@ucw.cz> <20061011134351.0c79445a.zaitcev@redhat.com>
In-Reply-To: <20061011134351.0c79445a.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121017.52655.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 22:43, Pete Zaitcev wrote:
> On Wed, 11 Oct 2006 19:44:43 +0000, Pavel Machek <pavel@suse.cz> wrote:
> 
> > Does it mean text interface is now deprecated? Or perhaps ioctl should
> > be added to text interface too? Or maybe we do not need binary
> > interface if we allow resizing on text interface?
> 
> I haven't reviewed Paolo's patch yet, but with that in mind:
>  - No, text is not deprecated yet. That is only possible when a simplified
>    command-line tool is written and distributed (e.g. usbmon(8)).
>  - No, I do not think an ioctl in debugfs or a text API is a good idea.
>  - Resizing on text interface magnifies sprintf contribution to CPU burn,
>    so once we have the binary one, there's only disadvantage and
>    no advantage in implementing that.

By the way, any reason why CONFIG_USB_MON doesn't select CONFIG_DEBUG_FS?
Is usbmon useful without debugfs?

Ciao,

Duncan.
