Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVCZIeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVCZIeP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 03:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVCZIdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 03:33:14 -0500
Received: from mx1.mail.ru ([194.67.23.121]:12365 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261952AbVCZIc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 03:32:56 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.12-rc1-bk1: Inconsistent kallsyms data
Date: Sat, 26 Mar 2005 11:32:51 +0300
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200503260343.03342.adobriyan@mail.ru> <20050326080918.GA16087@mars.ravnborg.org>
In-Reply-To: <20050326080918.GA16087@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503261132.51309.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 March 2005 11:09, Sam Ravnborg wrote:
> On Sat, Mar 26, 2005 at 03:43:03AM +0300, Alexey Dobriyan wrote:
> > While building 2.6.12-rc1-bk1 with attached config I get "Inconsistent
> > kallsyms data".
> >
> > Setting CONFIG_KALLSYMS_EXTRA_PASS or CONFIG_KALLSYMS_ALL fixes the
> > problem.
>
> Please try attached patch.

Thanks, Sam. It works.

> What you see may be the linker deciding to re-shuffle some sections a bit
> more than usual.
> Patch has been in -mm for a while. 

Oh, that's why -mm3 was ok. :-)

> # ChangeSet
> #   2005/03/14 20:56:01+01:00 sam@mars.ravnborg.org
> #   kbuild: Avoid inconsistent kallsyms data

> #   Tested by: Paulo Marques <pmarques@grupopie.com>
> #   Tested by: Alexander Stohr <Alexander.Stohr@gmx.de>

Tested-by: Alexey Dobriyan <adobriyan@mail.ru>
