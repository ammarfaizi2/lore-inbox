Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUF1Wb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUF1Wb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF1Wb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:31:56 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:17119 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S264255AbUF1Wbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:31:34 -0400
Date: Mon, 28 Jun 2004 18:31:21 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Scott Wood <scott@timesys.com>, oliver@neukum.org, zaitcev@redhat.com,
       greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       stern@rowland.harvard.edu, mdharm-usb@one-eyed-alien.net,
       david-b@pacbell.net
Subject: Re: drivers/block/ub.c
Message-ID: <20040628223121.GA5811@yoda.timesys>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <20040628141517.GA4311@yoda.timesys> <20040628132531.036281b0.davem@redhat.com> <200406282257.11026.oliver@neukum.org> <20040628140343.572a0944.davem@redhat.com> <20040628211857.GA5508@yoda.timesys> <20040628152208.20fe97f1.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628152208.20fe97f1.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 03:22:08PM -0700, David S. Miller wrote:
> On Mon, 28 Jun 2004 17:18:57 -0400
> Scott Wood <scott@timesys.com> wrote:
> > As long as bar is not packed, why shouldn't the beginning of bar.b be
> > aligned?
> 
> No!  bar.b starts at offset 1 byte.  That's how this stuff works.

That may be how it does work, but why is that how it *should* work?
If I want bar packed, I'll specify it as packed.  There's no reason
to keep this behavior with a nopadding attribute, as it would be a
new attribute with no existing code to break.

The important thing is that the offsets within the packed/nopadding
struct are exactly as specified, and padding the first element
doesn't change that.

-Scott
