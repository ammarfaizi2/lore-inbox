Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUBRWmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266927AbUBRWmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:42:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:19663 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266687AbUBRWmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:42:19 -0500
Date: Wed, 18 Feb 2004 14:40:52 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.3 + hp100 -> Oops
Message-Id: <20040218144052.2cc12a31@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040218221641.GA1182@bougret.hpl.hp.com>
References: <20040218201559.GA31872@bougret.hpl.hp.com>
	<20040218124034.05c9f6aa@dell_ss3.pdx.osdl.net>
	<20040218221641.GA1182@bougret.hpl.hp.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 14:16:41 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> On Wed, Feb 18, 2004 at 12:40:34PM -0800, Stephen Hemminger wrote:
> > 
> > This should fix the problem... The multi-bus probe logic error handling was
> > botched.
> 
> 	Thanks. The driver now seems to works. However, the kernel
> messages no longer show the device name...

That is a generic problem that can't easily be fixed since the device name
isn't assigned till board is registered which happens after successful probe.
