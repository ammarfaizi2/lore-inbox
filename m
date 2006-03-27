Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWC0Pda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWC0Pda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWC0Pda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:33:30 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5089 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751086AbWC0Pda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:33:30 -0500
Date: Mon, 27 Mar 2006 09:33:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, ebiederm@xmission.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, sam@vilain.net
Subject: Re: [RFC][PATCH 2/2] Virtualization of IPC
Message-ID: <20060327153326.GA18378@sergelap.austin.ibm.com>
References: <44242B1B.1080909@sw.ru> <44242DFE.3090601@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44242DFE.3090601@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):

Thanks for sending the patches.

> +#define msg_ctlmax	(current->ipc_ns->msg_ctlmax)
> +#define msg_ctlmnb	(current->ipc_ns->msg_ctlmnb)
> +#define msg_ctlmni	(current->ipc_ns->msg_ctlmni)

Oh my - woe to the person trying to figure out why

	current->ipc_ns->msg_ctlmax = 20;

isn't compiling.

-serge
