Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUATUWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUATUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:22:24 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:55817 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265745AbUATUWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:22:23 -0500
Date: Tue, 20 Jan 2004 20:21:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix updates
Message-ID: <20040120202132.A20668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, akpm@osdl.org,
	davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
References: <200401152154.i0FLscIG023452@fsgi900.americas.sgi.com> <20040116144132.A24555@infradead.org> <400D6A5B.7090009@sgi.com> <20040120180851.A18872@infradead.org> <400D8BBF.7070005@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <400D8BBF.7070005@sgi.com>; from pfg@sgi.com on Tue, Jan 20, 2004 at 02:12:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 02:12:47PM -0600, Patrick Gefre wrote:
> Guess I don't understand your point. Do you want us to create separate 
> functions for soft-struct and bridge address
> and TIO and non-TIO - 4 functions for each register access, rather than 1 ?

The right fix would be to only have one, and that one would take the
bridge_t.  If you really want to have one that takes the pcibr_soft, too
make it a small wrapper.  But even that would be two and not four, where
do the other two come from?

