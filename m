Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTE3IfQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTE3IfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:35:16 -0400
Received: from verein.lst.de ([212.34.189.10]:6374 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263451AbTE3IfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:35:15 -0400
Date: Fri, 30 May 2003 10:48:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: "H. J. Lu" <hjl@lucon.org>
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Recent binutils releases and linux kernel 2.5.69+
Message-ID: <20030530084824.GA29758@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	"H. J. Lu" <hjl@lucon.org>,
	"ismail (cartman) donmez" <kde@myrealbox.com>,
	linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
References: <20030529074448.A29931@lucon.org> <20030529084948.A30796@lucon.org> <20030529160326.GB19751@lst.de> <200305291921.47154.kde@myrealbox.com> <20030529095940.B31904@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529095940.B31904@lucon.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 09:59:40AM -0700, H. J. Lu wrote:
> > > > This is a kernel issue and should be fixed in kernel unless we want
> > > > to do something in <sys/sysctl.h>.
> > >
> > > You should not include kernel headers from userspace.
> > 
> > Old story I know but I dont think binutils would use kernel headers if it 
> > doesnt need it.
> > 
> 
> <sys/sysctl.h> includes <linux/sysctl.h>. That is what I meant by "do
> something in <sys/sysctl.h>."

I know. and <linux/sysctl.h> is a kernel header libc shouldn't include.
So you want to do something to <sys/sysctl.h>, namely get rid of it's
depency on kernel headers.

