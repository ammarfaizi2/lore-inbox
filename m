Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUBSRfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUBSRfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:35:33 -0500
Received: from gprs157-229.eurotel.cz ([160.218.157.229]:51584 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267429AbUBSRf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:35:29 -0500
Date: Thu, 19 Feb 2004 18:35:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Message-ID: <20040219173514.GD259@elf.ucw.cz>
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org> <20040219072629.GB467@openzaurus.ucw.cz> <opr3l0mfdw4evsfm@smtp.pacific.net.th> <20040219161455.GC259@elf.ucw.cz> <opr3mok1ko4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr3mok1ko4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >That means that PG_nosave | PG_reserved indeed is "PG_donttouch", but
> >PG_nosave has slightly different meaning.
> 
> Makes sense, but PG_reserved is used to keep VM out of these pages.
> 
> Can we have a seperate bit PG_donttouch which is set with PG_nosave
> | PG_reserved in reserved/video/BIOS/Broken CPU areas?

Why?

I do not see what is wrong with 2 separate flags... In fact, you might
want to 

#define PG_donttouch (PG_reserved | PG_nosave)

and (modulo atomic macros etc), it would work for everyone...
 
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
