Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVC3VPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVC3VPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVC3VME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:12:04 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:20906 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261175AbVC3VLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:11:07 -0500
Date: Wed, 30 Mar 2005 13:11:02 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: linux-os <linux-os@analogic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, binutils@sources.redhat.com,
       Andi Kleen <ak@muc.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050330211102.GB15384@lucon.org>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org> <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org> <Pine.LNX.4.61.0503301120130.27995@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503301120130.27995@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 11:23:25AM -0500, linux-os wrote:
> 
> So if there are any "movw (mem), %ds" and
> "movw %ds, (mem)" in the code. The sizeof(mem)
> needs to be 32-bits and the 'w' needs to be removed.
> Otherwise, we are wasting CPU cycles and/or fooling
> ourselves. GAS needs to continue to generate whatever
> it was fed, with appropriate diagnostics if it
> is fed the wrong stuff.

FYI, gas hasn't generated 0x66 on "movw (%eax),%ds" for a long time
and started doing it on "movw %ds,(%eax)" since Nov. 4, 2004.


H.J.
