Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWGDIX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWGDIX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWGDIX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:23:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10136 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932066AbWGDIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:23:26 -0400
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@sgi.com>
Cc: Milton Miller <miltonm@bga.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44AA2301.2030400@sgi.com>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>
	 <200607040516.k645GFTj014564@sullivan.realtime.net>
	 <44AA1D09.7080308@sgi.com> <1151999591.3109.8.camel@laptopd505.fenrus.org>
	 <44AA2301.2030400@sgi.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 10:23:19 +0200
Message-Id: <1152001399.3109.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 10:12 +0200, Jes Sorensen wrote:
> 
> Guess the question is, is there a way we can detect when media has
> been
> inserted without doing open/close on the device constantly? 

they could just keep the device open.... at least until media is
inserted


also they should poll at most every 10 seconds; anything more frequent
is just braindead...


