Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTJ3APZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbTJ3APZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:15:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:16792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261649AbTJ3APX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:15:23 -0500
Date: Wed, 29 Oct 2003 16:24:58 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Ref-count problem in kset_find_obj?
In-Reply-To: <20031029123820.GA1141@mschwid3.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44.0310291623420.1023-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The reference count of the kobject to be returned is not
> increased before the semaphore is released. A kobject_del/unlink
> could remove the object before the called of kset_find_obj is
> able to increase the reference count. This makes kset_find_obj
> more or less unusable, doesn't it?

Yes, you're right. The function is pretty much unused, and I don't have a 
problem removing it, provided we can fix up the one user 
(arch/i386/kernel/edd.c). Unless of course, you're planning on using it..


	Pat


