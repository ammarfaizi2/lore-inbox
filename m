Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWIELFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWIELFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWIELFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:05:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:45703 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751414AbWIELFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:05:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH -mm] PM: Remove sleeping from suspend_console
Date: Tue, 5 Sep 2006 13:08:37 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>,
       Laurent Riffard <laurent.riffard@free.fr>
References: <200609042250.41592.rjw@sisk.pl> <20060905062842.GA21738@suse.de>
In-Reply-To: <20060905062842.GA21738@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609051308.38401.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 5 September 2006 08:28, Stefan Seyfried wrote:
> On Mon, Sep 04, 2006 at 10:50:40PM +0200, Rafael J. Wysocki wrote:
> > Remove ssleep() from suspend_console().
> > 
> > Stefan thinks it is unnecessary and will slow down the suspend too much.
> 
> "unnecessary" is not exactly what i think, rather "unacceptable" :-)

Still that implies it's not necessary. ;-)

> We probably need to do something for some kinds of consoles to make sure all
> characters are sent, but sleeping unconditionally is not the right thing IMO.

Yup.  This was added as a result of the Laurent Riffard's report that the sleep
was necessary, but it turned out to be due to the network card problem, so we
should get rid of the ssleep().

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
