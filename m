Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUDULwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUDULwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 07:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUDULwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 07:52:31 -0400
Received: from ee.oulu.fi ([130.231.61.23]:24731 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264524AbUDULwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 07:52:30 -0400
Date: Wed, 21 Apr 2004 14:52:10 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
cc: Neil Brown <neilb@cse.unsw.edu.au>, arjanv@redhat.com,
       Andrew Morton <akpm@osdl.org>, b-gruber@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
In-Reply-To: <xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
Message-ID: <Pine.GSO.4.58.0404211442170.26430@stekt37>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
 <Pine.GSO.4.58.0404191124220.21825@stekt37> <20040419015221.07a214b8.akpm@osdl.org>
 <xb77jwci86o.fsf@savona.informatik.uni-freiburg.de> <1082372020.4691.9.camel@laptop.fenrus.com>
 <16518.20890.380763.581386@cse.unsw.edu.au> <xb71xmhfu9j.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite heated discussion, which is why I've avoided it =) But just to
clarify my intentions... Dmitry raised some valid issues about the problems
in the current version of psaux driver. I might try fixing some/all of
them, however I believe I got a better idea.

On Wed, 21 Apr 2004, Sau Dan Lee wrote:

>I second!  Let's  free /dev/psaux.  We want the  /dev/psaux as in 2.4,
>2.2, 2.0, ...  We don't want a faked, censored one as in 2.6.0--5.

We shouldn't want _the_ /dev/psaux, but something similar, possibly
better. What I'm after (and probably Sau Dan Lee too) is direct access to
at least psaux-port.

My idea is to modify serio to expose all (or at least all unconnected)
ports into userspace, where programs can write/read them just like the
/dev/psaux before. Then it's just matter of symlinking /dev/psaux into
correct device.

The biggest problem as I see is that this is much more intrusive change and
a standalone kernel driver (as psaux.ko currently is) is impossible.

I'll be back when I have some code, before that, all suggestions are
welcome (special thanks for Dmitry for insights).
