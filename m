Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVAGEii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVAGEii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVAGEih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:38:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23702 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261240AbVAGEie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:38:34 -0500
Date: Fri, 7 Jan 2005 04:38:32 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Lukasz Kosewski <lkosewsk@nit.ca>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: SCSI aic7xxx driver: Initialization Failure over a kdump reboot
Message-ID: <20050107043832.GR27371@parcelfarce.linux.theplanet.co.uk>
References: <1105014959.2688.296.camel@2fwv946.in.ibm.com> <1105013524.4468.3.camel@laptopd505.fenrus.org> <20050106195043.4b77c63e.akpm@osdl.org> <41DE15C7.6030102@nit.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DE15C7.6030102@nit.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:53:27PM -0500, Lukasz Kosewski wrote:
> I have an idea of something I might do for 2.6.11, but I doubt anyone
> will actually agree with it.  Say we keep a counter of how many times
> interrupt x has been fired off since the last timer interrupt
> (obviously, a timer interrupt resets the counter).  Then we can pick an
> arbitrary threshold for masking out this interrupt until another device
> actually pines for it.
> 
> Or something.  The point is, we need a general solution to the problem,
> not poking about in every single driver trying to tie it down.

Something like note_interrupt() in kernel/irq/spurious.c?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
