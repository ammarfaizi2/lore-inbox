Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUCBAhb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 19:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbUCBAhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 19:37:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:36801 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261524AbUCBAhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 19:37:13 -0500
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0403020019340.7718-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0403020019340.7718-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1078187189.21575.165.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 11:26:29 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 11:22, James Simmons wrote:

> > It's a bit difficult to fix it while keeping memcmp, except if we do
> > a local copy of the var structure, which would eat stack space...
> 
> Yeah its a old bug. I don't know of a clean way to do that.

Heh, well... we have 2 choices, that's as simple as that: field-by-field
compare, or local copy + memcmp. It'd probably go for the first one...

Ben.


