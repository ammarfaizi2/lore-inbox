Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbUDNHLO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263931AbUDNHLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:11:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:1440 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263376AbUDNHLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:11:13 -0400
Date: Wed, 14 Apr 2004 08:11:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Fabian Frederick <Fabian.Frederick@skynet.be>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
Message-ID: <20040414071102.GB7790@mail.shareable.org>
References: <1081881778.5585.16.camel@bluerhyme.real3> <20040413170309.14b7a334.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040413170309.14b7a334.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Do races in access() actually matter?  I mean, some other process could
> change things a nanosecond after access() has completed and the value which
> the access() caller received is wrong anyway.

What about the effect access() has on other callers?  It temporarily
changes current->fsuid, so fs operations in other completely
independent threads are affected.

-- Jamie
