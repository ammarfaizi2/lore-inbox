Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVCPJAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVCPJAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVCPJAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:00:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:41351 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262130AbVCPJAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:00:43 -0500
Date: Wed, 16 Mar 2005 10:00:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <christoph@lameter.com>, linux-kernel@vger.kernel.org,
       Shai Fultheim <Shai@Scalex86.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] del_timer_sync: proof of concept
Message-ID: <20050316090024.GB11582@elte.hu>
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net> <42371941.CCBAB134@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42371941.CCBAB134@tv-sign.ru>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> New rules:
> 	->_base &  1	: is timer pending
> 	->_base & ~1	: timer's base

how would it look like if we had a separate timer->pending field after
all? Would it be faster/cleaner?

(we dont need to keep them small _that_ bad - if there's a good reason
we should rather add a clean new field than to encode two fields into
one field and complicate the code.)

	Ingo
