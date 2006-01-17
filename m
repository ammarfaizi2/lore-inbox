Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWAQQFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWAQQFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWAQQFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:05:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27087 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751297AbWAQQFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:05:42 -0500
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060117155600.GF20632@sergelap.austin.ibm.com>
References: <20060117143258.150807000@sergelap>
	 <20060117143326.283450000@sergelap>
	 <1137511972.3005.33.camel@laptopd505.fenrus.org>
	 <20060117155600.GF20632@sergelap.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:03:38 +0000
Message-Id: <1137513818.14135.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-17 at 09:56 -0600, Serge E. Hallyn wrote:
> The virtual pid is different depending on who is asking.  So simply
> storing current->realpid and current->pid isn't helpful, as we would
> still need to call a function when a pid crosses user->kernel boundary.

This is an obscure, weird piece of functionality for some special case
usages most of which are going to be eliminated by Xen. I don't see the
kernel side justification for it at all.

Maybe you should remap it the other side of the user->kernel boundary ?

