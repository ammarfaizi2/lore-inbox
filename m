Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUAGJbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 04:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbUAGJbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 04:31:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29456 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266167AbUAGJbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 04:31:52 -0500
Date: Wed, 7 Jan 2004 09:31:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107093143.A29200@flint.arm.linux.org.uk>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
	Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
References: <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0401061554010.9166@home.osdl.org> <m13casmk28.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m13casmk28.fsf@ebiederm.dsl.xmission.com>; from ebiederm@xmission.com on Tue, Jan 06, 2004 at 09:58:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 09:58:23PM -0700, Eric W. Biederman wrote:
> ffff0000-ffffffff : reserved
> 
> That last reserved region is 64K.  Which looking at the pci registers
> is technically correct at the moment.  Only 64K happen to be decoded.

We already have this distinction between in use (or busy) resources and
allocated resources.  Surely the BIOS ROM region should be an allocation
resource not a busy resource, so that the MTD driver can obtain a busy
resource against it?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
