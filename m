Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWHHVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWHHVzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWHHVzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:55:03 -0400
Received: from thunk.org ([69.25.196.29]:21142 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030261AbWHHVzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:55:01 -0400
Date: Tue, 8 Aug 2006 17:54:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060808215450.GA12365@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Kari Hurtta <hurtta+gmane@siilo.fmi.fi>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <eb8g8b$837$1@taverner.cs.berkeley.edu> <20060807225642.GA31752@nevyn.them.org> <200608071813.18661.chase.venters@clientec.com> <84144f020608080516k183072efmdcc8a4dfc334b2fe@mail.gmail.com> <5dpsfbrzaw.fsf@attruh.keh.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dpsfbrzaw.fsf@attruh.keh.iki.fi>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 07:02:15PM +0300, Kari Hurtta wrote:
> "Pekka Enberg" <penberg@cs.helsinki.fi> writes:
> 
> > On 8/8/06, Chase Venters <chase.venters@clientec.com> wrote:
> > > IIRC, it returns EBADF because the file actually gets closed. The file
> > > descriptor, on the other hand, is permanently leaked.
> > >
> > > Have these details changed?
> > 
> > No. Your description is accurate.
> > 
> >                                              Pekka
> 
> So application can not close() it and recover file description?

That would be correct behavior, IMHO, and matches what happens with a
tty hangup.

					- Ted
