Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWDYJEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWDYJEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWDYJEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:04:00 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:41672 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932150AbWDYJEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:04:00 -0400
Date: Tue, 25 Apr 2006 11:03:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
In-Reply-To: <444D3D32.1010104@argo.co.il>
Message-ID: <Pine.LNX.4.61.0604251102140.26791@yvahk01.tjqt.qr>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
 <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I think it's easy to show that the equivalent C++ code would be shorter,
> faster, and safer.
>
I doubt that. Mixing C and C++ leads to C++ code being slightly bigger than 
intended. In C, you can have

  struct ops *p = void_ptr;

In C++,

  struct ops *p = (struct ops *)void_ptr

or even

  struct ops *p = static_cast<struct ops *>(void_ptr);

And void*s are used a lot.


Jan Engelhardt
-- 
