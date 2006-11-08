Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753511AbWKHURa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbWKHURa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbWKHURa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:17:30 -0500
Received: from brick.kernel.dk ([62.242.22.158]:10031 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753511AbWKHURa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:17:30 -0500
Date: Wed, 8 Nov 2006 21:19:45 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
Message-ID: <20061108201945.GC4527@kernel.dk>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk> <87ejsd3gcr.fsf@sycorax.lbl.gov> <20061108192924.GA4527@kernel.dk> <1163016210.3138.382.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163016210.3138.382.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08 2006, Arjan van de Ven wrote:
> > Wonderful! So this is an INQUIRY command, yet the WRITE bit is set. The
> > drive gets really confused about that, for good reason. The question is
> > where that write bit comes from, it looks really odd. Additionally, we
> 
> it could be a userspace command; some userspace tools send inquiry via
> sg...

it is a userspace command, it originates from SG_IO. So that is a given.
The question is where the write bit comes from, I'd be puzzled if the
user app sets it - cdparanoia in this case. Seeing as there's other
request mangling, I hope the new debug patch can shed some light on
that.

-- 
Jens Axboe

