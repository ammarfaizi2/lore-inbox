Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKKM7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKKM7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 07:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKKM7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 07:59:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:2467 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750707AbVKKM7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 07:59:22 -0500
Subject: Re: [PATCH] getrusage sucks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <200511110211.05642.cloud.of.andor@gmail.com>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
	 <200511110123.29664.cloud.of.andor@gmail.com> <4373E69B.6040206@fbab.net>
	 <200511110211.05642.cloud.of.andor@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Nov 2005 13:30:16 +0000
Message-Id: <1131715816.3174.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-11 at 02:11 +0100, Claudio Scordino wrote:
> > You need to wrap this with a read_lock(&tasklist_lock) to be safe, I think.
> 
> Right. Probably this was the meaning also of Hua's mail. Sorry, but I didn't 
> get it immediately.
> 
> So, what if I do as follows ? Do you see any problem with this solution ?

It will depend on the data accuracy. If the information on cpu usage is
very accurate then it becomes a way to analyse what is happening to
tasks you don't own - such as say cryptographic functions in the web
server...

Otherwise, or with an owner check I see no real problem with the concept

