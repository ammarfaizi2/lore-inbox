Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVA3LVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVA3LVC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 06:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVA3LVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 06:21:02 -0500
Received: from av5-2-sn3.vrr.skanova.net ([81.228.9.114]:42208 "EHLO
	av5-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261678AbVA3LU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 06:20:57 -0500
To: dtor_core@ameritech.net
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <200501251155.20430.david-b@pacbell.net>
	<d120d50005012513304ba0ca88@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jan 2005 12:20:54 +0100
In-Reply-To: <d120d50005012513304ba0ca88@mail.gmail.com>
Message-ID: <m31xc388o9.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, 25 Jan 2005 11:55:20 -0800, David Brownell <david-b@pacbell.net> wrote:
> > The more serious one is that sometimes it seems to spontaneously emit click
> > events while I'm moving finger across pad.  Which means I've had to learn to
> > plan my "mouse" motions to avoid areas where clicking could have bad effects.
> > But that's not always possible ...
> 
> That is default sensitivity not suiting your habits I think. I would
> recomment trying out Synaptics X driver (which also does ALPS) so you
> will be able adjust sensitivity the way you like it.

I think the problem is that the tap detection in mousedev.c is very
simplistic. It always generates a button click if the time between
"finger down" and "finger up" is small enough, even if the finger was
moved a large x/y distance. The X driver handles this with another
parameter that specifies the maximum allowed distance. If the finger
moved more than this distance, no button event is generated.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
