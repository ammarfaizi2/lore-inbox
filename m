Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUK0SqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUK0SqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUK0SqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 13:46:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261301AbUK0SqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 13:46:03 -0500
Date: Sat, 27 Nov 2004 10:46:00 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, zaitcev@redhat.com
Subject: Re: [PATCH 2.4] usb serial write fix
Message-ID: <20041127104600.55395d78@lembas.zaitcev.lan>
In-Reply-To: <1099409108.2856.35.camel@deimos.microgate.com>
References: <mailman.1099321382.10097.linux-kernel2news@redhat.com>
	<20041101193616.2d517e77@lembas.zaitcev.lan>
	<1099404208.2856.25.camel@deimos.microgate.com>
	<1099409108.2856.35.camel@deimos.microgate.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Nov 2004 09:25:08 -0600, Paul Fulghum <paulkf@microgate.com> wrote:

> On Tue, 2004-11-02 at 08:03, Paul Fulghum wrote:
> > On Mon, 2004-11-01 at 21:36, Pete Zaitcev wrote:
> > > Why testing for signals? Do you expect any?
> > 
> > post_helper can run in a user process as well
> > as keventd. The user process can get a signal
> > like HUP to pppd.

> Signals sent to one user process can interfere with
> the processing of write requests from a different process.

This is a problem only _if_ we apply your patch (which checks for
signals), this is why I asked about it in the first place.

-- Pete
