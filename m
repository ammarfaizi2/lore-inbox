Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129257AbQKXSME>; Fri, 24 Nov 2000 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129231AbQKXSLy>; Fri, 24 Nov 2000 13:11:54 -0500
Received: from lin-hs2-013.inetnebr.com ([209.50.4.45]:20728 "EHLO
        falcon.inetnebr.com") by vger.kernel.org with ESMTP
        id <S129145AbQKXSLp>; Fri, 24 Nov 2000 13:11:45 -0500
Date: Fri, 24 Nov 2000 11:41:25 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
Message-ID: <20001124114125.A8019@potty.housenet>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E13yikV-0006ZQ-00@the-village.bc.nu> <Pine.LNX.4.10.10011241113540.9367-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10011241113540.9367-100000@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2000 at 11:15:50AM -0600, Oliver Xymoron wrote:
> You could still change it to
> __bug__module_is_using_a_delay_thats_too_large__please_report()..

I thought that's where we started?

Can we somehow use the GNU linker trick which permits a warning about e.g.
gets at link time?  (Is it even documented somewhere?)  Something like:

/* bad_udelay.c */
static char bad_udelay_warning[] __attribute__((__section__(".gnu.warning")))
	= "warning: constant udelay too long";
bad_udelay() { BUG(); }

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
