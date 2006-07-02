Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWGBSr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWGBSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWGBSr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:47:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53688 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932641AbWGBSr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:47:28 -0400
Subject: Re: 2.6.17-mm2
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, akpm@osdl.org, rjw@sisk.pl,
       davej@redhat.com, linux-kernel@vger.kernel.org, sekharan@us.ibm.com,
       rusty@rustcorp.com.au, sam@ravnborg.org
In-Reply-To: <20060702114233.7880cf12.rdunlap@xenotime.net>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	 <20060624172014.GB26273@redhat.com> <20060624143440.0931b4f1.akpm@osdl.org>
	 <200606251051.55355.rjw@sisk.pl> <20060625032243.fcce9e2e.akpm@osdl.org>
	 <20060625081610.9b0a775a.akpm@osdl.org>
	 <20060630003813.e1003a93.rdunlap@xenotime.net>
	 <20060702101146.GA26924@flint.arm.linux.org.uk>
	 <20060702114233.7880cf12.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sun, 02 Jul 2006 20:47:06 +0200
Message-Id: <1151866026.3111.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-02 at 11:42 -0700, Randy.Dunlap wrote:
> 
> Only if we have a policy of not exporting __init or __initdata or
> __exit.  Are we there yet??

__exit is harder, but __init and __initdata is obvious; those are tossed
out of memory before you can even load a module so exporting those HAS
to be a bug; no excuse possible.


