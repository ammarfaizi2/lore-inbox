Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270154AbTGMHu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270155AbTGMHu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:50:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28347
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270154AbTGMHuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:50:54 -0400
Subject: Re: SECURITY - data leakage due to incorrect strncpy implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200307122128.h6CLSGf1006376@eeyore.valparaiso.cl>
References: <200307122128.h6CLSGf1006376@eeyore.valparaiso.cl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058083373.31918.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:02:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 22:28, Horst von Brand wrote:
> Perhaps there should be a strncpy_touser() to make it crystal clear that it
> _can't_ be "optimized" into strlcpy()

The direct to_user functions are not normally a problem. The data they fail
to clear is the users own data anyway.

