Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVE0XYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVE0XYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVE0XYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:24:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:16041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262654AbVE0XYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:24:52 -0400
Date: Fri, 27 May 2005 16:25:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: ganesh.venkatesan@gmail.com, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shai@scalex86.org
Subject: Re: [PATCH] e1000: NUMA aware allocation of descriptors V2
Message-Id: <20050527162528.2ba5113e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505271450200.25909@graphe.net>
References: <Pine.LNX.4.62.0505171854490.20408@graphe.net>
	<20050517190343.2e57fdd7.akpm@osdl.org>
	<Pine.LNX.4.62.0505171941340.21153@graphe.net>
	<20050517.195703.104034854.davem@davemloft.net>
	<Pine.LNX.4.62.0505172125210.22920@graphe.net>
	<20050517215845.2f87be2f.akpm@osdl.org>
	<5fc59ff305051808558f1ce59@mail.gmail.com>
	<20050518134250.3ee2703f.akpm@osdl.org>
	<Pine.LNX.4.62.0505271450200.25909@graphe.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> NUMA awareness for the e1000 driver. Allocate tx and rx descriptors
> on the node of the device.
> 
> It is safe to replace vmalloc by kmalloc node since only the descriptors
> are allocated in a NUMA aware way. These will not be so large that the
> use of vmalloc becomes necesssary.

Really?  That's probably OK with the default number of tx descriptors, but
that number can be made arbitrarily large with a module parameter.

Could you please work this with the e1000 developers?
