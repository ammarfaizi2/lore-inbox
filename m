Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTESSnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTESSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:43:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30646
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262598AbTESSnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:43:17 -0400
Subject: Re: recursive spinlocks. Shoot.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ptb@it.uc3m.es
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305191727.h4JHRih00517@oboe.it.uc3m.es>
References: <200305191727.h4JHRih00517@oboe.it.uc3m.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053367077.29227.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2003 18:57:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-19 at 18:27, Peter T. Breuer wrote:
> :-). Well, whaddya know. Both read and write of a int (declared
> volatile) are atomic on ia32. 

Except when they aren't. There are ppro SMP issues about ordering of
unlocked stores in some situations. Thats why the PPro generates 
lock movb $0, foo for the unlock on PPro

Fixable however by PPro specific lock ops


