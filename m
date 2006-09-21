Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIUX6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIUX6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWIUX6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:58:41 -0400
Received: from smtp.reflexsecurity.com ([72.54.64.74]:55483 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S932121AbWIUX6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:58:40 -0400
Date: Thu, 21 Sep 2006 19:58:17 -0400
From: Jason Lunz <lunz@falooley.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Message-ID: <20060921235817.GA27170@knob.reflex>
References: <20060921235340.DBD89822B@knob.reflex>
In-Reply-To: <200609220046.32233.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The entire problem is we can't use file names during resume, because
> we can't mount filesystems at that time, so we need to represent the
> swap header's location in a filesystem-independent way.

grub reads files without mounting the filesystem. And it has to find the
entire file, not just the beginning. Maybe swsusp could use that
technique? If not the in-kernel one, surely the userland version
could.

Jason
