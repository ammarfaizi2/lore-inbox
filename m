Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbTADNsd>; Sat, 4 Jan 2003 08:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTADNsd>; Sat, 4 Jan 2003 08:48:33 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:54497 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S266928AbTADNsc>; Sat, 4 Jan 2003 08:48:32 -0500
Date: Sat, 4 Jan 2003 08:57:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation, second try (v850 part)
Message-ID: <20030104135706.GA12349@gnu.org>
References: <87hecp83yq.fsf@tc-1-100.kawasaki.gol.ne.jp> <20030104130352.GK10477@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030104130352.GK10477@pazke>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 04:03:52PM +0300, Andrey Panin wrote:
> I used arch_ prefix to clearly mark arch specifig things, but
> irq_valid() is probably a better name. Comments ?

You should only `mark arch specific things' when there's a reason --
after all, there are _lots_ of arch-specific definitions in linux, but very
rarely is it important to note that fact; the caller usually doesn't care.

[consider that it might be desirable at some point in the future to have a
arch-independent version of `irq_valid'; the callers shouldn't have to be
changed to accomodate such a change]

In the case of something like `arch_setup_irq', there _is_ a reason:  it's a
small arch-specific `core' for the real generic setup_irq (and one which will
probably be used _only_ by setup_irq).

-Miles
-- 
Ich bin ein Virus. Mach' mit und kopiere mich in Deine .signature.
