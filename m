Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTDOWyS (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTDOWyS 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:54:18 -0400
Received: from crack.them.org ([65.125.64.184]:51115 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S264144AbTDOWyQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:54:16 -0400
Date: Tue, 15 Apr 2003 19:06:04 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Eli Carter <eli.carter@inet.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: .section ... "ax" vs  #alloc, #execinstr
Message-ID: <20030415230604.GA22231@nevyn.them.org>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <3E9C664A.503@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9C664A.503@inet.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:06:34PM -0500, Eli Carter wrote:
> Some of the assembly files use
> .section        ".start", "ax"
> and others use
> .section ".start", #alloc, #execinstr
> (and not just for .start, try
> find -name \*.S | xargs grep -e '\.section'
> )
> 
> These appear to be equivelent, if not somebody clue me in please. :) 

They're equivalent.

> Which is the prefered form?  The latter seems to provide a bit more for 
> the human, so I'd vote that direction... ;)

Well, GCC prefers the former.  Binutils will accept either; they have
historically different origins.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
