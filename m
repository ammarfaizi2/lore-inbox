Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTJHVuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTJHVuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:50:50 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:11407
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261800AbTJHVur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:50:47 -0400
Subject: Re: [PATCH] Poll-based IDE driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vatsa@in.ibm.com
Cc: Dave Jones <davej@redhat.com>, lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <20031008174458.A32517@in.ibm.com>
References: <20030917144120.A11425@in.ibm.com>
	 <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
	 <20031008151357.A31976@in.ibm.com> <20031008115051.GD705@redhat.com>
	 <20031008174458.A32517@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065649708.10565.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Wed, 08 Oct 2003 22:48:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-10-08 at 13:14, Srivatsa Vaddagiri wrote:
> Since my code is supposed to run when system is crashing, I would like 
> to avoid calling any function in the kernel as far as possible, since 
> the kernel and its data structures may be in a inconsistent state 
> and/or corrupted.

For x86 udelay is a tiny piece of code - you could easily inline it

