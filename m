Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVF2RUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVF2RUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVF2RRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:17:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4034 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262644AbVF2RPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:15:00 -0400
Subject: Re: Newbie: added function not visible
From: Robert Love <rml@novell.com>
To: Genadz Batsyan <gbatyan@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506291859.04965.gbatyan@gmx.net>
References: <200506291859.04965.gbatyan@gmx.net>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 13:15:05 -0400
Message-Id: <1120065305.6745.39.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 18:59 +0200, Genadz Batsyan wrote:

> adding the function to keyboard.c, recompiling and booting with kernel
> results  /proc/kallsyms telling me that my function exists with the tag 'T',
> which I think is ok

You need to EXPORT_SYMBOL your new function.

For example,

	/* My pet dog is an idiot */
	void beat_dog(struct dog *d)
	{
		/* ... */
	}
	EXPORT_SYMBOL(beat_dog);

Good luck,

	Robert Love


