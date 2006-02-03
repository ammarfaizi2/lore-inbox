Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWBCWrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWBCWrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWBCWrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:47:32 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:39865 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750873AbWBCWrc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:47:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aUCsrFMqI7o9tQDWBZZ9fK89V2JvU2vlyqFtKnTjX7pI5vaUjNGE8z4uStZLB2IdfnNuS/V2J+qwyK6ZKfbyusHzhtoQgqrTAHbwrHnYSRAaAMfXY1y8lkWp7yhxZFoK954FJD/S9emTT+w0cHVHAoxBfOrbuxCBIIWUpQp+/hk=
Message-ID: <964857280602031447l57df7c1epced4a6f14979ce30@mail.gmail.com>
Date: Fri, 3 Feb 2006 20:47:31 -0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: menuconfig: no colors in 2.6.12-rc2 ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060203222843.GA11973@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602031957070.4864@dyndns.pervalidus.net>
	 <20060203222843.GA11973@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Sam Ravnborg wrote:
> On Fri, Feb 03, 2006 at 08:15:54PM -0200, Fr?d?ric L. W. Meunier wrote:
> > 2.6.15's menuconfig has colors, but 2.6.12-rc2 doesn't have. At
> > least here...
> ncursesw is now first choice.
> What does following command print:
>
> gcc -print-file-name=libncursesw.so
>
> If it prints just libncursesw.so then this is not the issue.
> But if it prints a full path similar to:
> /usr/lib/gcc/x86_64-pc-linux-gnu/3.4.4/../../../../lib64/libncursesw.so
> then this may be the case.

/usr/lib/gcc/i486-slackware-linux/3.4.5/../../../libncursesw.so

> Try to rename ncursesw to ncurses in
> scripts/kconfig/lxdialog/check-dialog.sh
> to test if ncursesw is the culprint.

Yes, that worked. Is it a bug in ncursesw ? I'm using a recent one.
