Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbTJJSPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 14:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTJJSPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 14:15:42 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5318 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263134AbTJJSPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 14:15:40 -0400
Date: Fri, 10 Oct 2003 14:12:51 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Miles Bader <miles@gnu.org>, miles@lsi.nec.co.jp,
       linux-kernel@vger.kernel.org
Subject: Re: initcall ordering of driver w/respect to tty_init?
Message-ID: <20031010181251.GA32720@fencepost>
References: <buo65j0f9vi.fsf@mcspd15.ucom.lsi.nec.co.jp> <20031010080212.6ddb02ff.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010080212.6ddb02ff.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Blat: Foop
From: Miles Bader <miles@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:02:12AM -0700, Randy.Dunlap wrote:
> | I have a tty driver, arch/v850/kernel/simcons.c, who's init function is
> | called via __initcall:
> 
> Does it help/work to change it to a console_initcall() ?

I think that would solve the problem, but is it the right solution?  How
about all those other drivers that call tty_register_driver?  module_init
becomes __initcall when driver is statically linked into the kernel...

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
