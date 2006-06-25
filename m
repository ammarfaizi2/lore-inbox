Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWFYSYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWFYSYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965319AbWFYSYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:24:09 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:56992 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S965312AbWFYSYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:24:08 -0400
Date: Sun, 25 Jun 2006 20:23:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, rdunlap@xenotime.net
Subject: Re: 2.6.17-mm2
Message-ID: <20060625182352.GB17945@mars.ravnborg.org>
References: <20060624061914.202fbfb5.akpm@osdl.org> <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org> <200606251051.55355.rjw@sisk.pl> <20060625032243.fcce9e2e.akpm@osdl.org> <20060625081610.9b0a775a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625081610.9b0a775a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2006 at 08:16:10AM -0700, Andrew Morton wrote:
> On Sun, 25 Jun 2006 03:22:43 -0700
> 
> Actually we should be able to address this pretty simply by disallowing
> exports of symbols which are in the __init section.  There's no sense in
> exporting something which ain't there.
> 
> IOW, any reference from __ksymtab, __ksymtab_gpl or __ksymtab_gpl_future
> into __init or __initdata should be a hard error.
We could let modpost error out. Then the module does not get build but
we detect it a bit later than optimal.

	Sam
