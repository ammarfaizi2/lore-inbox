Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWDXVlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWDXVlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWDXVlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:41:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751328AbWDXVlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:41:49 -0400
Subject: Re: C++ pushback
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Martin Mares <mj@ucw.cz>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <444D44F2.8090300@wolfmountaingroup.com>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	 <mj+md-20060424.201044.18351.atrey@ucw.cz>
	 <444D44F2.8090300@wolfmountaingroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 22:52:12 +0100
Message-Id: <1145915533.1635.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
> C++ in the kernel is a BAD IDEA. C++ code can be written in such a 
> convoluted manner as to be unmaintainable and unreadable.

So can C. 

> All of the hidden memory allocations from constructor/destructor 
> operatings can and do KILL OS PERFORMANCE. 

This is one area of concern. Just as big a problem for the OS case is
that the hidden constructors/destructors may fail. You can write C++
code carefully to avoid these things but it can be hard to see where the
problem is when you miss one.

C at least makes it verbose, but we trade that for poorer typechecking
and visibility control.

Alan

