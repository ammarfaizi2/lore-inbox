Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVGZENS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVGZENS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 00:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVGZENS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 00:13:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261622AbVGZENR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 00:13:17 -0400
Date: Mon, 25 Jul 2005 21:13:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Fw: Oops in hidinput_hid_event
Message-Id: <20050725211308.6fc3d134.zaitcev@redhat.com>
In-Reply-To: <20050725205226.6343f323.akpm@osdl.org>
References: <20050718141637.074c6f70.zaitcev@redhat.com>
	<20050725205226.6343f323.akpm@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 20:52:26 -0700, Andrew Morton <akpm@osdl.org> wrote:

> Do you expect this patch:
> 
> > --- linux-2.6.12/drivers/usb/input/hid-input.c	2005-06-21 12:58:47.000000000 -0700
> > -	struct input_dev *input = &field->hidinput->input;
> > +	struct input_dev *input;
> > -	if (!input)
> > +	if (!field->hidinput)
> >  		return;
> > +	input = &field->hidinput->input;

> To actually fix the above oops?  It sure looks like it will.
> But I worry whether it is the correct fix?

It is a correct fix, safe to apply. However, Vojtech wrote me that he
will look how exactly an event can be reported without associated
infrastructure. Personally, I suspect that this has something to do
with the motherboard in question. Perhas the PS/2 port is disabled
somehow...

-- Pete
