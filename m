Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWEJR0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWEJR0J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWEJR0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:26:08 -0400
Received: from homer.mvista.com ([63.81.120.158]:7455 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S965006AbWEJR0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:26:07 -0400
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Daniel Walker <dwalker@mvista.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060510164207.GD27946@ftp.linux.org.uk>
References: <200605100256.k4A2u8bd031779@dwalker1.mvista.com>
	 <1147257266.17886.3.camel@localhost.localdomain>
	 <1147271489.21536.70.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147273787.17886.46.camel@localhost.localdomain>
	 <1147273598.21536.92.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <1147275571.17886.64.camel@localhost.localdomain>
	 <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060510162106.GC27946@ftp.linux.org.uk>
	 <1147279038.21536.120.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060510164207.GD27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 10 May 2006 10:25:48 -0700
Message-Id: <1147281948.21536.127.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 17:42 +0100, Al Viro wrote:

> s/codepath.*/bug being fixed/

There's several that aren't fixing bugs , but I still think they are
useful . 

For instance, I found several drivers that defined tables used when the
driver is defined as a module, but I was compiling the driver built-in
so the table showed as "unused" . 

I added

#ifdef MODULE

...

#endif /* MODULE */

How about those ? 

Daniel

