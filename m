Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWGSMjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWGSMjn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWGSMjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:39:43 -0400
Received: from xenotime.net ([66.160.160.81]:61639 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964803AbWGSMjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:39:42 -0400
Date: Wed, 19 Jul 2006 05:39:40 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Martin Waitz <tali@admingilde.org>
cc: Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH 1/3] kernel-doc: ignore __devinit
In-Reply-To: <20060719070019.GB30212@admingilde.org>
Message-ID: <Pine.LNX.4.58.0607190536230.26709@shark.he.net>
References: <44BD5373.20104@oracle.com> <20060719070019.GB30212@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006, Martin Waitz wrote:

> hoi :)
>
> On Tue, Jul 18, 2006 at 02:32:35PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@xenotime.net>
> >
> > Ignore __devinit in function definitions so that kernel-doc won't
> > fail on them.
>
> why would it fall over __devinit?

It doesn't match any of those awful regex strings when
looking for function prototypes, so kernel-doc (the script)
coughs and dies, as noted in DocBook/kernel-api.tmpl
for drivers/pci/search.c.

> And shouldn't we add __{dev}?init{data}? while we are at it?

Yes, in theory at least (for __init and __exit, not __initdata,
since this is in function definitios).
I just haven't run into the need for those yet.

-- 
~Randy
