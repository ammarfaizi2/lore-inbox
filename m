Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422752AbWJFRDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422752AbWJFRDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWJFRDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:03:33 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:32463 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1422752AbWJFRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:03:32 -0400
Date: Fri, 6 Oct 2006 11:03:31 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Rename pdc_init
Message-ID: <20061006170331.GJ2563@parisc-linux.org>
References: <11601511393703-git-send-email-matthew@wil.cx> <4526876A.5090103@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526876A.5090103@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 12:42:18PM -0400, Jeff Garzik wrote:
> I don't mind the patch (you should have CC'd me and linux-ide though), 

We really need to figure out how to communicate that better.  I just
sent it to the maintainer (as listed in MODULE_AUTHOR).  Do we need a
MODULE_CHANGES_CC macro too?

> but where is parisc's pdc_init actually used, and why is it global?

Hmm.  Embarrassing.  Seems it's a stale prototype; I'll delete it.

OTOH, there is a pdc_init in avr32, and it's prudent to not have two
functions of the same name, so that you know which one is appearing in a
backtrace.  So it might be a good idea to apply this patch anyway.
