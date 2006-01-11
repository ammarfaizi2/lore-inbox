Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWAKTIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWAKTIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbWAKTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:08:04 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43191 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751775AbWAKTIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:08:02 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <ada3bju1td8.fsf@cisco.com>
References: <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
	 <1136915386.6294.8.camel@serpentine.pathscale.com>
	 <20060110175131.GA5235@infradead.org>
	 <1136915714.6294.10.camel@serpentine.pathscale.com>
	 <20060110140557.41e85f7d.akpm@osdl.org>
	 <1136932162.6294.31.camel@serpentine.pathscale.com>
	 <20060110153257.1aac5370.akpm@osdl.org>
	 <1137000032.11245.11.camel@camp4.serpentine.com>
	 <20060111172216.GA18292@mars.ravnborg.org>
	 <20060111093019.097d156a.akpm@osdl.org>
	 <1137001400.11245.31.camel@camp4.serpentine.com>
	 <adairsq1tx9.fsf@cisco.com>
	 <1137005865.11245.47.camel@camp4.serpentine.com>
	 <ada3bju1td8.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 11:08:01 -0800
Message-Id: <1137006481.11245.51.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 11:01 -0800, Roland Dreier wrote:

> Oh, I think you're misunderstanding Andrew's idea.  Just create a
> generic __raw_memcpy_toio32() that is always compiled, but mark it
> with attribute((weak)).  Then x86_64 can define its own version of
> __raw_memcpy_toio32(), which will override the weak generic version.

No, I understood that.  But my original x86_64 routine was inline, which
would have left the out-of-line version compiled, but not used, on
x86_64.

	<b

