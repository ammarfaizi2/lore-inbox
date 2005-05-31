Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVEaGXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEaGXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVEaGXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:23:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:131 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261213AbVEaGXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:23:09 -0400
Subject: Re: [patch 04/16] ext3: fix race between ext3 make block
	reservation and reservation window discard
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Rodrigo =?ISO-8859-1?Q?Steinm=FCller?= Wanderley 
	<rwanderley@natalnet.br>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Iuri [SBTVD]" <iuri@digizap.com.br>
In-Reply-To: <20050530102820.048644b2@localhost>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
	 <20050523232016.GP27549@shell0.pdx.osdl.net>
	 <20050530102820.048644b2@localhost>
Content-Type: text/plain; charset=utf-8
Organization: IBM LTC
Date: Mon, 30 May 2005 23:23:04 -0700
Message-Id: <1117520584.4652.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 10:28 -0300, Rodrigo Steinmüller Wanderley wrote:
> Hi,
>   Does this patch fix the "Assertion failure in log_do_checkpoint" for witch Jan Kara submitted a workaround to the list earlier?
> 
> http://lkml.org/lkml/2005/5/6/30
> 
> Thanks in advance,
>   Rodrigo Wanderley
> 

This patch really is to prevent re-remove an already removed reservation
window node from the filesystem red-black reservation tree. It has
nothing to do with the log_do_checkpoint failure.

Mingming

