Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUGSRhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUGSRhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 13:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUGSRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 13:37:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4346 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265348AbUGSRg4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 13:36:56 -0400
Date: Mon, 19 Jul 2004 13:36:54 -0400
From: "George G. Davis" <gdavis@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow `make O=<obj> {cscope,tags}` to work
Message-ID: <20040719173654.GB1890@mvista.com>
References: <20040719171759.GA1890@mvista.com> <20040719192430.GA7522@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719192430.GA7522@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 09:24:30PM +0200, sam@ravnborg.org wrote:
> On Mon, Jul 19, 2004 at 01:17:59PM -0400, George G. Davis wrote:

<snip>

> >  endef
> >  
> > -quiet_cmd_cscope-file = FILELST cscope.files
> > -      cmd_cscope-file = $(all-sources) > cscope.files
> > +quiet_cmd_cscope-file = FILELST $(obj)/cscope.files
> > +      cmd_cscope-file = $(all-sources) > $(obj)/cscope.files
> The $(obj) in this line should not be needed. Current directory
> defaults to $(obj) equals $(objtree) when executing make cscope.

Yep, I got carried away there, Thanks. Should I resubmit a revised patch?

TIA!

--
Regards,
George
