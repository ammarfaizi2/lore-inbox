Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271262AbTHCVH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271270AbTHCVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:07:57 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:48281 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271262AbTHCVGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:06:50 -0400
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel
	from being modified easily
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       devik@cdi.cz
In-Reply-To: <20030803180950.GA11575@outpost.ds9a.nl>
References: <20030803180950.GA11575@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059944575.31900.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 22:02:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 19:09, bert hubert wrote:
> up about Oppenheimer when disclaiming that you are 'just a coder'. The item
> to google on is: "ethics sweetness hydrogen bomb Oppenheimer"), I wrote
> a patch to disable /dev/kmem and /dev/mem, which is harmless on servers
> without X.

You can do this without modifications using the security interface
hooks. If you want to do it right with 2.4 or without security modules
you need to globally revoke CAP_SYS_RAWIO and CAP_SYS_MODULE otherwise
you merely made it harder.

> It blocks attempts by rootkits, such as devik's SucKIT, to hide themselves.
> 
> It is not a final solution but it raises the bar a lot. Please apply.

Fine in theory but you can do this via security modules so its better if
you write a security policy module for it.

