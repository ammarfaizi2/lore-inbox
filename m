Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269410AbUJGATj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269410AbUJGATj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUJGATj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:19:39 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:1031 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S269410AbUJGATi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:19:38 -0400
Date: Thu, 7 Oct 2004 02:19:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007001937.GA48516@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20041006193053.GC4523@pclin040.win.tue.nl> <003301c4abdc$c043f350$b83147ab@amer.cisco.com> <20041006200608.GA29180@dspnet.fr.eu.org> <20041006163521.2ae12e6d.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006163521.2ae12e6d.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 04:35:21PM -0700, David S. Miller wrote:
> On Wed, 6 Oct 2004 22:06:08 +0200
> Olivier Galibert <galibert@pobox.com> wrote:
> 
> > On Wed, Oct 06, 2004 at 12:43:27PM -0700, Hua Zhong wrote:
> > > How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> > > it's not set?
> > 
> > Programs don't expect EAGAIN from blocking sockets.
> 
> That's right, which is why we block instead.

Programs don't expect a read to block after a positive select either,
so it doesn't really help.

  OG.

