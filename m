Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264165AbUFPRIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbUFPRIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUFPRHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:07:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62451 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S264247AbUFPRFF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:05:05 -0400
Date: Wed, 16 Jun 2004 10:04:46 -0700
From: Jun Sun <jsun@mvista.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] make ps2 mouse work ...
Message-ID: <20040616100446.J28403@mvista.com>
References: <20040615191023.G28403@mvista.com> <20040615205611.1e9cbfcc.akpm@osdl.org> <20040616121149.GA9325@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040616121149.GA9325@ucw.cz>; from vojtech@suse.cz on Wed, Jun 16, 2004 at 02:11:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 02:11:49PM +0200, Vojtech Pavlik wrote:
> On Tue, Jun 15, 2004 at 08:56:11PM -0700, Andrew Morton wrote:
> 
> > > I found this problem on a MIPS machine.  The problem is 
> > > likely to happen on other register-rich RISC arches too.
> > > 
> > > cmdcnt needs to be volatile since it is modified by
> > > irq routine and read by normal process context.
> > 
> > volatile is not the preferred way to fix this up.  This points at either a
> > locking error in the psmouse driver or a missing "memory" thingy in the
> > mips port somewhere.
> > 
> > Please describe the bug which led to this patch.  Where was it getting stuck?
> 
> My current BK tree has this fixed using atomic bitfields, which do
> compilation and memory barriers. I plan to sync it to Linus post 2.6.7.
> 

Can you post the patch here?  I am sure many people are eagerly waiting
for the right fix.  Plus there will be extra pairs of eyes to exam the fix.

Jun
