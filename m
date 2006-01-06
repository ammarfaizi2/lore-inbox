Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWAFLWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWAFLWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWAFLWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:22:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17622 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932418AbWAFLWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:22:22 -0500
Subject: Re: [patch 5/7]  uninline capable()
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <200601061218.17369.mbuesch@freenet.de>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	 <1136544160.2940.20.camel@laptopd505.fenrus.org>
	 <200601061218.17369.mbuesch@freenet.de>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 12:22:19 +0100
Message-Id: <1136546539.2940.28.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 12:18 +0100, Michael Buesch wrote:
> On Friday 06 January 2006 11:42, you wrote:
> > Index: linux-2.6.15/include/linux/sched.h
> > ===================================================================
> > --- linux-2.6.15.orig/include/linux/sched.h
> > +++ linux-2.6.15/include/linux/sched.h
> > @@ -1102,19 +1102,8 @@ static inline int sas_ss_flags(unsigned 
> >  }
> >  
> >  
> > -#ifdef CONFIG_SECURITY
> > -/* code is in security.c */
> > +/* code is in security.c or kernel/sys.c if !SECURITY */
> >  extern int capable(int cap);
> 
> BTW, is there a special reason why this is declared in sched.h
> instead of capability.h?

probably a lot of historic bagage... anyway not something that should be
cleaned up as part of this series, could maybe be done in another patch
if you feel so inclined :)


