Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUHPHlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUHPHlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUHPHlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:41:45 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:28800 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S265812AbUHPHkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:40:55 -0400
Subject: Re: [PATCH][2.4.27] PowerPC 745x data corruption bug fix
From: Adrian Cox <adrian@humboldt.co.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200408160254.i7G2ss3S000656@harpo.it.uu.se>
References: <200408160254.i7G2ss3S000656@harpo.it.uu.se>
Content-Type: text/plain
Message-Id: <1092642051.959.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 08:40:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 03:54, Mikael Pettersson wrote:
> On Mon, 16 Aug 2004 08:13:59 +1000, Paul Mackerras wrote:

> >Does CONFIG_MPC10X_BRIDGE mean just MPC107, or is it set for (e.g.)
> >systems with a MPC106 as well?
> 
> I just copied this part from 2.6.8. Currently it
> seems CONFIG_MPC10X_BRIDGE is set for some platforms
> (sandpoint and lopec), but it is definitely not set
> for MPC106 machines like my beige PowerMac G3.

I don't understand how your patch can improve the stability of your
machine when CONFIG_MPC10X_BRIDGE isn't set. 

Pages should be marked coherent for the MPC106 as well as the MPC107,
but the problem shouldn't be seen unless the processor supports the
shared cache line state. My original patch only set
CPU_FTR_NEED_COHERENT for the 745x family, as only 745x plus 604 have
the shared state, but Tom Rini extended it to cover all the other
processors. I'm not convinced that extending it was necessary, but the
performance impact should be low.

Also, are you sure that you have an MPC106 together with a 7455
processor?  I thought that the 7455 required a revision D or later
MPC107.

- Adrian Cox
Humboldt Solutions Ltd.


