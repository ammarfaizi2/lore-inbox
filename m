Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUAHR0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUAHR0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:26:15 -0500
Received: from smtp.terra.es ([213.4.129.129]:56048 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S265136AbUAHR0M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:26:12 -0500
Date: Thu, 8 Jan 2004 18:26:21 +0100
From: Diego Calleja <grundig@teleline.es>
To: Ian Kent <raven@themaw.net>
Cc: arvidjaar@mail.ru, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-Id: <20040108182621.1278db90.grundig@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0401082333280.449-100000@donald.themaw.net>
References: <E1Aeab1-0009FQ-00.arvidjaar-mail-ru@f20.mail.ru>
	<Pine.LNX.4.44.0401082333280.449-100000@donald.themaw.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 8 Jan 2004 23:40:16 +0800 (WST) Ian Kent <raven@themaw.net> escribió:

> 
> Again I'm also unable to find descriptions of the 'unsolvable' races.
> 
> I wouldn't mind knowing what they are either. Anyone?

You can find tons of examples (several of them patches by Al Viro to fix them) by
searching with google with keywords like "devfs races". The "should fix" list
(http://www.kernel.org/pub/linux/kernel/people/akpm/must-fix) has this:

hch: devfs: there's a fundamental lookup vs devfsd race that's only
  fixable by introducing a lookup vs devfs deadlock.  I can't see how this is
  fixable without getting rid of the current devfsd design.  Mandrake seems
  to have a workaround for this so this is at least not triggered so easily,
  but that's not what I'd consider a fix..
