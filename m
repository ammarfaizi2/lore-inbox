Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbSLSDLl>; Wed, 18 Dec 2002 22:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbSLSDLl>; Wed, 18 Dec 2002 22:11:41 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22283
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267518AbSLSDLk>; Wed, 18 Dec 2002 22:11:40 -0500
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	state = (take 1)
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA30@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA30@orsmsx116.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040267987.848.130.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 22:19:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 21:40, Perez-Gonzalez, Inaky wrote:

> Well, I think it makes kind of sense. If we know we are
> returning to some place where nothing bad could happen
> with reordering ... well, so be it, don't use __set_...()

Oh, I see.  If it returns to somewhere that immediately e.g. puts it on
a wait queue.  In that case, yep: need the barrier version.

> And that would now really work when CONFIG_X86_OOSTORE=1 is required
> [after all, it is a write, so it'd need the equivalent of a wmb() or
> xchg()].

Is this a hint that your employer may have an x86 chip in the future
with weak ordering? :)

> Okay, changing that one too, just in case.

Good - better safe than sorry.

	Robert Love

