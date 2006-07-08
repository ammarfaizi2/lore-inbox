Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWGHGmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWGHGmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWGHGmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:42:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32948 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751301AbWGHGmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:42:51 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Arjan van de Ven <arjan@infradead.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jes Sorensen <jes@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, John Daiker <jdaiker@osdl.org>,
       John Hawkes <hawkes@sgi.com>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dan Higgins <djh@sgi.com>
In-Reply-To: <20060708001427.GA723842@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com>
	 <1151578513.3122.22.camel@laptopd505.fenrus.org>
	 <20060708001427.GA723842@sgi.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 08:42:43 +0200
Message-Id: <1152340963.3120.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> So does i386 convert the return value of the times(2) call to user
> hertz?  On IA64, it returns the value in internal clock ticks, and
> then when a program uses the value in param.h, it gets it wrong now,
> because internal HZ is now 250.
> 
> So is times() is broken in IA64, or is this an exception to Alan's
> statement?

yes it's broken; it needs to convert it to the original HZ (1024) and
make the sysconf() function also return 1024


