Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVCUQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVCUQpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCUQpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 11:45:32 -0500
Received: from orb.pobox.com ([207.8.226.5]:7128 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261229AbVCUQpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 11:45:24 -0500
Date: Mon, 21 Mar 2005 10:45:17 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH][2.6.12-rc1-mm1] fix compile error in ppc64 prom.c
Message-ID: <20050321164517.GB16469@otto>
References: <200503211519.j2LFJ1os021884@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503211519.j2LFJ1os021884@harpo.it.uu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:19:01PM +0100, Mikael Pettersson wrote:
> Compiling 2.6.12-rc1-mm1 for ppc64 fails with:
> 
> arch/ppc64/kernel/prom.c:1691: error: syntax error before 'prom_reconfig_notifier'
> arch/ppc64/kernel/prom.c:1692: error: field name not in record or union initializer
> arch/ppc64/kernel/prom.c:1692: error: (near initialization for 'prom_reconfig_nb')
> arch/ppc64/kernel/prom.c:1692: warning: initialization makes pointer from integer without a cast
> make[1]: *** [arch/ppc64/kernel/prom.o] Error 1
> make: *** [arch/ppc64/kernel] Error 2
> 
> Fix: repair the obvious syntax error (missing "=").

Thanks for the fix; the mistake was mine.  Lest Andrew and Paulus
think I'm sending untested patches, the compiler I'm using (gcc
3.3.3-hammer) does not give an error or even a warning.  Sorry for the
inconvenience; I'll have to upgrade to a less forgiving version of
gcc.


Nathan
