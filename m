Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUBYIkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 03:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUBYIkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 03:40:14 -0500
Received: from poup.poupinou.org ([195.101.94.96]:23044 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262475AbUBYIkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 03:40:11 -0500
Date: Wed, 25 Feb 2004 09:39:57 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Stefan Seyfried <seife@suse.de>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] swsusp/s3: Assembly interactions need asmlinkage
Message-ID: <20040225083957.GE2869@poupinou.org>
References: <20040224130051.GA8964@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040224130051.GA8964@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 02:00:51PM +0100, Pavel Machek wrote:
> Hi!
> 
> swsusp/s3 assembly parts, and parts called from assembly are not
> properly marked asmlinkage; that leads to double fault on resume when
> someone compiles kernel with regparm. Thanks go to Stefan Seyfried for
> discovering this. Please apply,

Does acpi_enter_sleep_state_s4bios() have the same issue ?


-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
