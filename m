Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266697AbTGFQfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbTGFQfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:35:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:33925 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266697AbTGFQfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:35:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 6 Jul 2003 09:42:07 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Matthew Wilcox <willy@debian.org>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kobjects, sysfs and the driver model make my head hurt
In-Reply-To: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.55.0307060935140.14675@bigblue.dev.mcafeelabs.com>
References: <20030706163353.GU23597@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jul 2003, Matthew Wilcox wrote:

> Why on earth does it return the value of its argument?

Maybe for the same reason 'strcpy' returns 'dest'. It allows you to use
the function in a function parameter :

obj *get(obj *o);
int rel(obj *o);
int foo(int q, obj *o);

foo(17, get(o));
rel(o);



- Davide

