Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTFDRb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTFDRb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 13:31:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57476
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263510AbTFDRb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 13:31:58 -0400
Subject: Re: [PATCH] [2.5] Non-blocking write can block
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, "P. Benie" <pjb1008@eng.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306040732470.13753-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0306040732470.13753-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054745247.9233.119.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 17:47:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-06-04 at 15:35, Linus Torvalds wrote:
> In general, we shouldn't do this, unless somebody can show an application 
> where it really matters. Taking internal kernel locking into account for 
> "blockingness" easily gets quite complicated, and there is seldom any real 
> point to it.

Hanging shutdown is the obvious one. With 2.0/2.2 we had a similar
problem and fixed it.

