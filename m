Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbTJUR3Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJUR3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 13:29:24 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:10002 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263201AbTJUR3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 13:29:00 -0400
Date: Tue, 21 Oct 2003 18:28:55 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Svetoslav Slavtchev <svetljo@gmx.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6-mm] radeonfb as module 
In-Reply-To: <574.1066736914@www3.gmx.net>
Message-ID: <Pine.LNX.4.44.0310211828021.32738-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> acquire_console_sem is exported, 
> but release_console_sem is not
> 
> this seems like a bug for me,
> as if one acquire console_sem, he should be able to relase it


True that release_console_sem should be exported as well. But that lock 
shouldn't be in a driver. In fbcon.c yes but not the driver. My next pacth 
will fix that.


