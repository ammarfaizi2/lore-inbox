Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWBRJWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWBRJWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 04:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBRJWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 04:22:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4062 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751085AbWBRJWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 04:22:21 -0500
Subject: Re: [PATCH 1/5] [pm] Fix locking of device suspend/resume functions
From: Arjan van de Ven <arjan@infradead.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org
In-Reply-To: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 10:22:16 +0100
Message-Id: <1140254536.2968.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-17 at 18:03 -0800, Patrick Mochel wrote:
> This patch removes the unneeded down()/up() calls from
> suspend_device() and resume_device(). Those functions
> are already called under the dpm_sem, making this code
> unconditionally deadlock in SMP kernels.

this wants to be a mutex as well ;)

