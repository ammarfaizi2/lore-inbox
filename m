Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWCUOrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWCUOrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWCUOrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:47:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37058 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751741AbWCUOrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:47:12 -0500
Subject: Re: referring a user address from ioctl entry point
From: Arjan van de Ven <arjan@infradead.org>
To: yogeshwar sonawane <yogyas@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <b681c62b0603210644p41711a16ydda5b18bfb531641@mail.gmail.com>
References: <b681c62b0603210644p41711a16ydda5b18bfb531641@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 15:47:08 +0100
Message-Id: <1142952429.3077.87.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 20:14 +0530, yogeshwar sonawane wrote:
> Hi all,
> 
> can we write directly to user virtual address from kernel space?
> i.e. dereferencing a user address from driver entry point?
> 

No this is not allowed and a big security hole at minimum.
You HAVE to use copy_from_user / copy_to_user and similar API to do
this. Be glad the FC3 kernel doesn't allow this at all ;)


