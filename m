Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTAFPhT>; Mon, 6 Jan 2003 10:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266993AbTAFPhT>; Mon, 6 Jan 2003 10:37:19 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:46090
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266991AbTAFPhT>; Mon, 6 Jan 2003 10:37:19 -0500
Subject: Re: Why do some net drivers require __OPTIMIZE__?
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Alex Bennee <alex@braddahead.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1030106095704.1580A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1030106095704.1580A-100000@chaos.analogic.com>
Content-Type: text/plain
Organization: 
Message-Id: <1041867947.730.8.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 10:45:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 10:04, Richard B. Johnson wrote:

> You need to optimize in order enable inline code generation. It is
> essential to use in-line code in many places because, if the compiler
> actually calls these functions they would have to be protected
> from reentry.

I do not think this is correct.

Concurrency concerns would not change wrt calling the function vs.
inlining it.

More likely some code, i.e. asm, just assumes inlining is taking place.

	Robert Love

