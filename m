Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUA1O2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 09:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUA1O2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 09:28:38 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:12681 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265960AbUA1O2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 09:28:37 -0500
Subject: Re: Fix sleep_on abuse in XFS, Was: Re: 2.6.2-rc2-mm1 (Breakage?)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org,
       David =?ISO-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
In-Reply-To: <20040128133357.A28038@infradead.org>
References: <20040127233402.6f5d3497.akpm@osdl.org>
	 <200401281313.03790.ender@debian.org>
	 <200401281225.37234.s0348365@sms.ed.ac.uk>
	 <20040128133357.A28038@infradead.org>
Content-Type: text/plain
Message-Id: <1075300114.1633.156.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 28 Jan 2004 14:28:34 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-28 at 13:33 +0000, Christoph Hellwig wrote:
> +	complete(&pagebuf_daemon_done);
>  	return 0;

Use complete_and_exit() please. S'what it was invented for.

-- 
dwmw2

