Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUC2NHI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUC2ND7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:03:59 -0500
Received: from mail.shareable.org ([81.29.64.88]:27027 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262910AbUC2NDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:03:12 -0500
Date: Mon, 29 Mar 2004 14:03:04 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040329130304.GE4984@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <20040328044029.GB1984@bounceswoosh.org> <40667734.8090203@yahoo.com.au> <20040328203357.GB6405@bounceswoosh.org> <20040328205917.GF6405@bounceswoosh.org> <40677C21.7070807@yahoo.com.au> <20040329052405.GG6405@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329052405.GG6405@bounceswoosh.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Mon, Mar 29 at 11:30, Nick Piggin wrote:
> >Well strictly, you send them one after the other. So unless you
> >have something similar to our anticipatory scheduler or plugging
> >mechanism, the drive should attack the first one first, shouldn't
> >it?
> 
> If you send 32 commands to our disk at once (TCQ/NCQ) we send 'em all
> to our back-end disk engine as fast as possible.

Are they sent _at once_, or are they sent in sequence?  If they're
sent in sequence, even if it's a very rapid sequence, than Nick's
point still stands.  If you're not attacking the first request which
arrives, the instant the drive code sees it, you're doing something
similar to the anticipatory scheduler.

-- Jamie
