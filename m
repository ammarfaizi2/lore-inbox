Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbTDNWhj (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTDNWhj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:37:39 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33293
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264101AbTDNWhh 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:37:37 -0400
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
From: Robert Love <rml@tech9.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030414222110.GK9640@fs.tum.de>
References: <20030414222110.GK9640@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1050359780.3664.114.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 18:36:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 18:21, Adrian Bunk wrote:

> If my patch is wrong and this is a RTFM please give me a hint where to 
> find the "M".

Patch looks right...

> Questions:
> Is it really correct to enable CONFIG_X86_USE_3DNOW?

If you are right that the K6-2 and K6-3D support 3DNow!, then yes.  At
least its "correct" but it may not be optimal: I seem to recall 3DNow
memory copies were not worthwhile on anything before an Athlon.  Double
check that, though.

> Is the -march=k6-2 correct?

Yes.  Even if the above is true, splitting the K6 out like this is
useful for the extra -march here.  It certainly does not hurt (picking
the original K6 will give proper support for the whole family, in
needed).

	Robert Love

