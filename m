Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVAaVEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVAaVEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVAaVEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:04:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:42896 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261373AbVAaVEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:04:06 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16894.40247.701998.555392@tut.ibm.com>
Date: Mon, 31 Jan 2005 15:03:51 -0600
To: karim@opersys.com
Cc: Tom Zanussi <zanussi@us.ibm.com>, Andi Kleen <ak@muc.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux, part 2
In-Reply-To: <41FE89E0.9030802@opersys.com>
References: <16890.38062.477373.644205@tut.ibm.com>
	<m1d5volksx.fsf@muc.de>
	<16892.26990.319480.917561@tut.ibm.com>
	<20050131125758.GA23172@muc.de>
	<16894.23610.315929.805524@tut.ibm.com>
	<41FE89E0.9030802@opersys.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour writes:
 > 
 > Tom Zanussi wrote:
 > > OK, makes sense to me - I'll get rid of relay_reserve and replace it
 > > with the simple putc write and variant.
 > 
 > Please don't do that. Instead, bring back the ad-hoc mode code, that's
 > what is was for anyway.
 > 

I don't think they need to be mutually exclusive - we could keep
relay_reserve(), but the relay_write() that's currently built on top
of relay_reserve() would use the putc code instead.  It's complicating
the API a bit, but if it makes everyone happy...

Tom

