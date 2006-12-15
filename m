Return-Path: <linux-kernel-owner+w=401wt.eu-S1752939AbWLORIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbWLORIT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbWLORIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:08:18 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:46483 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbWLORIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:08:18 -0500
Date: Fri, 15 Dec 2006 09:08:43 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Zack Weinberg" <zackw@panix.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, jmorris@namei.org,
       "Chris Wright" <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Message-Id: <20061215090843.3bff4ab9.randy.dunlap@oracle.com>
In-Reply-To: <eb97335b0612141721g2e983574k4ea698caa316de6d@mail.gmail.com>
References: <20061215001639.988521000@panix.com>
	<20061215002334.039728000@panix.com>
	<20061214170229.d0f06a57.randy.dunlap@oracle.com>
	<eb97335b0612141721g2e983574k4ea698caa316de6d@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 17:21:25 -0800 Zack Weinberg wrote:

> On 12/14/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > > +#define security_syslog_or_fail(type) do {           \
> > > +             int error = security_syslog(type);      \
> > > +             if (error)                              \
> > > +                     return error;                   \
> > > +     } while (0)
> > > +
> >
> > From Documentation/CodingStyle:
> >
> > Things to avoid when using macros:
> >
> > 1) macros that affect control flow: ...
> 
> It says "avoid", not "never use".  If you can think of another way to
> code this function that won't completely obscure the actual operations
> with the security checks, I will be happy to change it.

The usual answer is to just open-code it.  You may dislike that,
but hiding control flow in macros is held as really bad by
more than just me.

---
~Randy
