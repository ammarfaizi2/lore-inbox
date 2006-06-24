Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWFXRnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWFXRnK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFXRnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:43:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7646 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750987AbWFXRnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:43:09 -0400
Subject: Re: [PATCH] ieee1394: dv1394: sem2mutex conversion
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.7092f9b969592375@s5r6.in-berlin.de>
References: <tkrat.7092f9b969592375@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 19:42:55 +0200
Message-Id: <1151170975.3181.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 19:37 +0200, Stefan Richter wrote:
> 
> -               if (down_trylock(&video->sem)) {
> +               if (mutex_trylock(&video->mtx)) {

this is a bug!

mutex_trylock follows the spinlock trylock convention, not the semaphore
trylock convention!!!


