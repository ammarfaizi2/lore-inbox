Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWBXXwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWBXXwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBXXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:52:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32772 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964803AbWBXXwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:52:34 -0500
Date: Sat, 25 Feb 2006 00:52:27 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm2
Message-ID: <20060224235227.GA9975@mars.ravnborg.org>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
> 
> - Sam's new section-mismatch warning code detects 358 errors in my alpha
>   build, and a quick sampling indicates that they're real.  Once this hits
>   mainline things will get somewhat messy.
To put credits right I just ported the functionality of the two scripts
developed by Keith Owens (reference_init.pl and reference_discarded.pl)
to modpost so the check is run each time moduels are build. All errors
introduced in the process are mine.
The scripts are kept for now so one can double check.

I had in mind to fix some of the easier ones but work is hindering it
atm.

For now it gives a warning when a drivers uses module_parm_array() and
uses __initdata for parameters. This is a false warning - at least if
sysfs attribute is '0'. Hope to look into this later.

	Sam
