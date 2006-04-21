Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWDUNQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWDUNQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWDUNQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:16:53 -0400
Received: from relay4.usu.ru ([194.226.235.39]:20865 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S932257AbWDUNQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:16:53 -0400
Message-ID: <4448DBC6.2090700@ums.usu.ru>
Date: Fri, 21 Apr 2006 19:19:02 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Chris Rankin <rankincj@yahoo.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 05/22] : Fix hotplug race during device registration
References: <20060421125329.4210.qmail@web52910.mail.yahoo.com>
In-Reply-To: <20060421125329.4210.qmail@web52910.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.34.0.24; VDF: 6.34.0.217; host: usu2.usu.ru)
X-AV-Checked: ClamAV using ClamSMTP@relay4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Rankin wrote:
> With reference to this patch:
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blobdiff;h=2731570eba5b35a21c311dd587057c39805082f1;hp=dfb62998866ae2e298139164a85ec0757b7f3fc7;hb=9469d458b90bfb9117cbb488cfa645d94c3921b1;f=net/core/dev.c
> 
> Doesn't this patch introduce another bug when registration fails, because reg_state is left as
> NETREG_REGISTERED?

This could be fixed up by saving the old value and restoring it in the "if 
(err)" statement, but I guess this has to be fixed in the mainline before 
allowing the modified "if (err)" into -stable.

-- 
Alexander E. Patrakov
