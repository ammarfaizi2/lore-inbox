Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161262AbWJKUqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbWJKUqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWJKUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:46:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161262AbWJKUqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:46:10 -0400
Date: Wed, 11 Oct 2006 13:43:51 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Paolo Abeni <paolo.abeni@email.it>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: [PATCH] usbmon: add binary interface
Message-Id: <20061011134351.0c79445a.zaitcev@redhat.com>
In-Reply-To: <20061011194443.GA3935@ucw.cz>
References: <1160557065.9547.12.camel@localhost.localdomain>
	<20061011194443.GA3935@ucw.cz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 19:44:43 +0000, Pavel Machek <pavel@suse.cz> wrote:

> Does it mean text interface is now deprecated? Or perhaps ioctl should
> be added to text interface too? Or maybe we do not need binary
> interface if we allow resizing on text interface?

I haven't reviewed Paolo's patch yet, but with that in mind:
 - No, text is not deprecated yet. That is only possible when a simplified
   command-line tool is written and distributed (e.g. usbmon(8)).
 - No, I do not think an ioctl in debugfs or a text API is a good idea.
 - Resizing on text interface magnifies sprintf contribution to CPU burn,
   so once we have the binary one, there's only disadvantage and
   no advantage in implementing that.

-- Pete
