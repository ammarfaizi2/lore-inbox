Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUGVUpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUGVUpo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUGVUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:45:42 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28043 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267237AbUGVUpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:45:16 -0400
Date: Fri, 23 Jul 2004 00:45:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "George G. Davis" <gdavis@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow `make O=<obj> {cscope,tags}` to work
Message-ID: <20040722224558.GB9561@mars.ravnborg.org>
Mail-Followup-To: "George G. Davis" <gdavis@mvista.com>,
	linux-kernel@vger.kernel.org
References: <20040719171759.GA1890@mvista.com> <20040719192430.GA7522@mars.ravnborg.org> <20040719173654.GB1890@mvista.com> <20040719182925.GC1890@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040719182925.GC1890@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 02:29:25PM -0400, George G. Davis wrote:
> On Mon, Jul 19, 2004 at 01:36:54PM -0400, George G. Davis wrote:
> > On Mon, Jul 19, 2004 at 09:24:30PM +0200, sam@ravnborg.org wrote:
> > > On Mon, Jul 19, 2004 at 01:17:59PM -0400, George G. Davis wrote:
> > 
> > <snip>
> > 
> > > >  endef
> > > >  
> > > > -quiet_cmd_cscope-file = FILELST cscope.files
> > > > -      cmd_cscope-file = $(all-sources) > cscope.files
> > > > +quiet_cmd_cscope-file = FILELST $(obj)/cscope.files
> > > > +      cmd_cscope-file = $(all-sources) > $(obj)/cscope.files
> > > The $(obj) in this line should not be needed. Current directory
> > > defaults to $(obj) equals $(objtree) when executing make cscope.
> > 
> > Yep, I got carried away there, Thanks. Should I resubmit a revised patch?
> 
> Ok, after clutzing about with bk fix, etc., here's the revised patch:

Thanks. Added to my local kbuild tree.

	Sam
