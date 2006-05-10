Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWEJO5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWEJO5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWEJO5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:57:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45503 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964968AbWEJO5x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:57:53 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 10 May 2006 16:09:47 +0100
Message-Id: <1147273787.17886.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 07:31 -0700, Daniel Walker wrote:
> > Hiding warnings like this can be a hazard as it will hide real warnings
> > later on.
> 
> How could it hide real warnings? If anything these patch allow other
> (real warnings) to be seen . 

Because while the warning is present people will check it now and again.
If you set the variable to zero then you generate extra code and you
ensure nobody will look in future.

