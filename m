Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUHSIsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUHSIsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 04:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUHSIq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 04:46:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263971AbUHSIq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 04:46:28 -0400
Subject: Re: PF_MEMALLOC in 2.6
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040818235523.383737cd@lembas.zaitcev.lan>
References: <20040818235523.383737cd@lembas.zaitcev.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1092905178.2038.0.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Aug 2004 09:46:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-08-19 at 07:55, Pete Zaitcev wrote:
> The PF_MEMALLOC is required on usb-storage threads in 2.4, because ext3
> will deadlock and otherwise misbehave when it's trying to write out
> dirty pages under memory pressure.

> I received a bug report today from an FC3T1 user with same symptoms
> as 2.4. But I'm entirely clueless in the way VM operates. Comments?


> @@ -285,7 +285,7 @@ static int usb_stor_control_thread(void 
> -	current->flags |= PF_NOFREEZE;
> +	current->flags |= PF_NOFREEZE|PF_MEMALLOC;

Looks entirely reasonable to me.

--Stephen

