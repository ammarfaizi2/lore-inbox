Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946697AbWKAIRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946697AbWKAIRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946700AbWKAIRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:17:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946697AbWKAIRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:17:20 -0500
Subject: Re: preferred way of fw loading
From: Arjan van de Ven <arjan@infradead.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       R.E.Wolff@BitWizard.nl
In-Reply-To: <4547E720.4080505@gmail.com>
References: <4547E720.4080505@gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 01 Nov 2006 09:17:18 +0100
Message-Id: <1162369038.3044.80.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 01:15 +0100, Jiri Slaby wrote:
> Hello,
> 
> is preferred to have firmware in kernel binary (and go through array of chars)
> or userspace (and load it through standard kernel api)?


generally the preferred way is for you to use request_firmware() API
which causes userspace to upload it to you via standard mechanisms.
This avoids kernel size bloat if it's not needed (by only having the
firmware in memory that is really really needed) and also avoids the
entire question of "can it be done within GPL" (not saying it can or
cannot, but usually if someone asks its a huge flamewar and this just
sidesteps the entire issue)


