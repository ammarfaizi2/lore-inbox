Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbTD3VMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTD3VMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:12:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56982
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262431AbTD3VMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:12:14 -0400
Subject: Re: [RFC][PATCH] Faster generic_fls
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       dphillips@sistina.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051734350.20270.28.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Apr 2003 21:25:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-30 at 17:16, Linus Torvalds wrote:
> Clearly you're not going to make _one_ load to get fls, since having a 
> 4GB lookup array for a 32-bit fls would be "somewhat" wasteful.

It ought to be basically the same as ffs because if I remember rightly 

ffs(x^(x-1)) == fls(x)

Been a long time so I may have it wrong

