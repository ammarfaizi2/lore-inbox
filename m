Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWGXUAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWGXUAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWGXUAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:00:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751427AbWGXUAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:00:33 -0400
Subject: Re: [PATCH for 2.6.18rc2] [1/7] i386/x86-64: Don't randomize stack
	top when no randomization personality is set
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <44c514a8.6HlRR82y133O2bd0%ak@suse.de>
References: <44c514a8.6HlRR82y133O2bd0%ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 24 Jul 2006 22:00:26 +0200
Message-Id: <1153771226.3043.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -	if (current->flags & PF_RANDOMIZE) {
> +	if ((current->flags & PF_RANDOMIZE) &&
> +		!(current->personality & ADDR_NO_RANDOMIZE)) {

these should be exclusive anyway, isn't the right solution to clear
PF_RANDOMIZE on ADDR_NO_RANDOMIZE personality ?

