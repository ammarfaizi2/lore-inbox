Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTHMWtY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271941AbTHMWtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:49:24 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:49566 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S271938AbTHMWtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:49:23 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.0-test3-mm1
Date: Thu, 14 Aug 2003 00:49:19 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <20030809203943.3b925a0e.akpm@osdl.org> <3F37DFDC.6080308@mvista.com> <20030813201829.GA15012@mars.ravnborg.org>
In-Reply-To: <20030813201829.GA15012@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308140049.20465.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 August 2003 22:18, Sam Ravnborg wrote:
> On Mon, Aug 11, 2003 at 11:26:36AM -0700, George Anzinger wrote:
> > >that patch sets DEBUG_INFO to y by default, even if whether DEBUG_KERNEL
> > >nor KGDB is enabled. The attached patch changes this to enable
> > > DEBUG_INFO by default only if KGDB is enabled.
> >
> > Looks good to me, but.... just what does this turn on?  Its been a
> > long time and me thinks a wee comment here would help me remember next
> > time.
>
> DEBUG_INFO add "-g" to CFLAGS.
> Main reason to introduce this was that many architectures always use
> "-g", so a config option seemed more appropriate.
> I do not agree that this should be dependent on KGDB.
> To my knowledge -g is useful also without using kgdb.

Yes, one can enable or disable DEBUG_INFO as soon as DEBUG_KERNEL is selected, 
this does not depend on KGDB.

With the patch DEBUG_INFO is enabled by default only if KGDB is selected, but 
even if KGDB is not selected you still may enable it by hand.

The problem was that DEBUG_INFO was enabled even if it was not reachable 
because DEBUG_KERNEL was not selected....

  Thomas
