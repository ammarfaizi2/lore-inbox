Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265921AbRGCTL3>; Tue, 3 Jul 2001 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265929AbRGCTLT>; Tue, 3 Jul 2001 15:11:19 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:38311 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S265921AbRGCTLI>; Tue, 3 Jul 2001 15:11:08 -0400
Date: Tue, 3 Jul 2001 20:11:06 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pte_val(*pte) as lvalue
Message-ID: <20010703201106.B31954@flint.arm.linux.org.uk>
In-Reply-To: <9LUWoC.A.W3G.sIQQ7@dinero.interactivesi.com.suse.lists.linux.kernel> <oupelryykh5.fsf@pigdrop.muc.suse.de> <LScPx.A.XAF.H_gQ7@dinero.interactivesi.com> <20010703194300.A31954@flint.arm.linux.org.uk> <3B4213DD.50005@interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4213DD.50005@interactivesi.com>; from ttabi@interactivesi.com on Tue, Jul 03, 2001 at 01:50:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 01:50:05PM -0500, Timur Tabi wrote:
> Russell King wrote:
> >Can I ask what the nature of the PTE modification is, and where you
> >are making this modification?
> >
> I've written a hack which enables PAT (Page Address Translation) for a 
> particular page:

Firstly, I'll say I'm no x86 expert by any means.  However, it may be
better to extend the pte bit handling functions in
include/asm-i386/pgtable.h to include the bits you need to handle.
(eg, see how pte_mkwrite and pte_wrprotect are implemented.)  This is
probably the cleanest way of handling these bits.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

