Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936960AbWLFRyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936960AbWLFRyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936962AbWLFRye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:54:34 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3667 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936960AbWLFRyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:54:33 -0500
Date: Wed, 6 Dec 2006 17:54:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jan Blunck <jblunck@suse.de>
Cc: Phil Endecott <phil_arcwk_endecott@chezphil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061206175423.GA9959@flint.arm.linux.org.uk>
Mail-Followup-To: Jan Blunck <jblunck@suse.de>,
	Phil Endecott <phil_arcwk_endecott@chezphil.org>,
	linux-kernel@vger.kernel.org
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com> <1165418558832@dmwebmail.belize.chezphil.org> <20061206155439.GA6727@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206155439.GA6727@hasse.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 04:54:39PM +0100, Jan Blunck wrote:
> Maybe the arm backend is somehow broken. AFAIK (and I verfied it on S390 and
> i386) the alignment shouldn't change.

Please read the info pages:

`packed'
     This attribute, attached to an `enum', `struct', or `union' type
     definition, specifies that the minimum required memory be used to
     represent the type.

     Specifying this attribute for `struct' and `union' types is
     equivalent to specifying the `packed' attribute on each of the
     structure or union members.  Specifying the `-fshort-enums' flag
     on the line is equivalent to specifying the `packed' attribute on
     all `enum' definitions.

Note that it says *nothing* about alignment.  It says "minimum required
memory be used to represent the type." which implies that the internals
of the structure are packed together as tightly as possible.

It does not say "and as such the struct may be aligned to any alignment".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
