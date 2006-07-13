Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWGMUye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWGMUye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 16:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGMUye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 16:54:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030385AbWGMUyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 16:54:33 -0400
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality
	permits it
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <200607132351.04721.a1426z@gawab.com>
References: <200607112257.22069.a1426z@gawab.com>
	 <p73sll6n73t.fsf@verdi.suse.de> <20060713094402.GB2448@janus>
	 <200607132351.04721.a1426z@gawab.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 22:54:31 +0200
Message-Id: <1152824071.3024.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> BTW, why does randomize_stack_top() mod against (8192*1024) instead of (8192) 
> like arch_align_stack()?
> 

 because it wants to randomize for 8Mb, unlike arch_align_stack which
wants to randomize the last 8Kb within this 8Mb ;)


