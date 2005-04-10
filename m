Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVDJRkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDJRkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDJRkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:40:22 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:59088 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261530AbVDJRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:40:05 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050410172759.GA16654@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <42596101.3010205@cybsft.com>  <20050410172759.GA16654@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 10 Apr 2005 13:39:53 -0400
Message-Id: <1113154793.20980.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 19:27 +0200, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > Ingo,
> > 
> > It would seem that in the latest patch RT-V0.7.45-00 we have reverted 
> > back to removing the define of jbd_debug which the attached patch 
> > (against one of the 2.6.11 versions) fixed.
> 
> > +#define jbd_debug(f, a...)   /**/
> 
> oops, indeed. '/**/' happens to be my private marker for 'debug code', 
> which the release scripts automatically strip from the files ...
> 
> i've uploaded -45-01 with the fix.
> 

Would there be any harm with changing that to 

#define jbd_debug(f, a...) do {} while(0)

The compiler would strip it anyway, and you wouldn't have to worry about
your scripts removing the macro.

-- Steve


