Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWHERpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWHERpY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWHERpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 13:45:24 -0400
Received: from s-utl01-sjpop.stsn.net ([72.254.0.201]:40837 "HELO
	s-utl01-sjpop.stsn.net") by vger.kernel.org with SMTP
	id S1422657AbWHERpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 13:45:23 -0400
Subject: Re: Zeroing data blocks
From: Arjan van de Ven <arjan@infradead.org>
To: Avinash Ramanath <avinashr@gmail.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <abcd72470608051013s42ba14e1g8c3289a3e551c7ca@mail.gmail.com>
References: <abcd72470607081856i47f15dedre9be9278ffa9bab4@mail.gmail.com>
	 <1152435182.3255.39.camel@laptopd505.fenrus.org>
	 <abcd72470608050055w51f2bfbcrbd26b59fc32dc494@mail.gmail.com>
	 <1154790620.3054.69.camel@laptopd505.fenrus.org>
	 <abcd72470608051013s42ba14e1g8c3289a3e551c7ca@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 05 Aug 2006 19:42:22 +0200
Message-Id: <1154799834.3054.93.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 10:13 -0700, Avinash Ramanath wrote:
> Hi,
> 
> I want to do this at the filesystem-level not in user-space.
> I have a stackable-filesystem that runs as a layer on top of the
> existing filesystem (with all the function pointers mapped to the
> corresponding base filesystem function pointers, and other suitable
> adjustments).
> So yes I have access to the filesystem.
> But the question is how can I access those particular data-blocks?

I think you misunderstood: You need to do this in the filesystem layer
that allocates and tracks the blocks. You really can't do it outside
that...


