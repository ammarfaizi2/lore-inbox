Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTJQNhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJQNhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:37:04 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:33157 "EHLO jaguar")
	by vger.kernel.org with ESMTP id S263464AbTJQNhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:37:02 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Colin Ngam <cngam@sgi.com>, Patrick Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
References: <3F872984.7877D382@sgi.com> <20031013095652.A25495@infradead.org>
	<yq0llrmncus.fsf@trained-monkey.org>
	<20031015135558.A8963@infradead.org>
	<yq0brshwcrx.fsf@trained-monkey.org> <3F8ECA11.C4281A8C@sgi.com>
	<20031017091125.A22492@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 17 Oct 2003 09:36:58 -0400
In-Reply-To: <20031017091125.A22492@infradead.org>
Message-ID: <yq03cdsx9xh.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> Of course - but that's not that point.  You have to handle
Christoph> an out of memory situtation propery because it may happen
Christoph> all the time - you should not panic at all.  The
Christoph> ASSERT_ALWAYS just confuses automatic checker tools that
Christoph> help to find such conditions.

Again,

>From a purely theoretical standpoint as I don't remember the code in
question's situation, this again depends on where in the codepath you
hit this. If you don't get your memory for certain key data structures
early on, there's really very little you can do but panic().

Jes
