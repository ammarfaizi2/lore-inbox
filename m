Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWDGQoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWDGQoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWDGQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:44:11 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:51137 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932457AbWDGQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:44:09 -0400
Date: Fri, 7 Apr 2006 11:45:14 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 09/17] uml: fix critical typo for TT mode
Message-ID: <20060407154514.GB4911@ccure.user-mode-linux.org>
References: <20060407142709.19201.99196.stgit@zion.home.lan> <20060407143110.19201.91963.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407143110.19201.91963.stgit@zion.home.lan>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 04:31:10PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Noticed this for a compilation-time warning, so I'm fixing it even for TT mode -
> this is not put_user, but copy_to_user, so we need a pointer to sp, not sp
> itself (we're trying to write the word pointed to by the "sp" var.).
> 
> Jeff, have I misunderstood anything?

No, you're right.  Al spotted this as well, and I have this fix in my tree.

				Jeff
