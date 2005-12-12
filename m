Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVLLNj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVLLNj3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 08:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbVLLNj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 08:39:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1152 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750958AbVLLNj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 08:39:28 -0500
Date: Mon, 12 Dec 2005 13:39:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: [BUG] Variable stopmachine_state should be volatile
Message-ID: <20051212133926.GA23908@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	"Shah, Rajesh" <rajesh.shah@intel.com>, linux-ia64@vger.kernel.org
References: <8126E4F969BA254AB43EA03C59F44E8404210E76@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E8404210E76@pdsmsx404>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are right. I hit the problem when I compiled kernel 2.6.9 on IA64 by intel compiler.
> cpu_relax has the compiler barrier if we use gcc, but cpu_relax becomes just ia64_hint which is null when I use intel compiler to compile kernel on ia64. file include/asm-ia64/intel_intrin.h defines ia64_hint as null.

Please report all bugs using ICC to intel.  We can't and don't want to debug
this mess.

