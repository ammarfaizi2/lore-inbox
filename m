Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbVCKOBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbVCKOBG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 09:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbVCKOBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 09:01:06 -0500
Received: from [62.206.217.67] ([62.206.217.67]:38889 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S263309AbVCKOBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 09:01:03 -0500
Message-ID: <4231A498.4020101@trash.net>
Date: Fri, 11 Mar 2005 15:00:56 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Last night Linus bk - netfilter busted?
References: <200503110223.34461.dtor_core@ameritech.net>
In-Reply-To: <200503110223.34461.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> My box gets stuck while booting (actually starting ntpd) whith tonight
> pull from Linus. It looks like it is spinning in ipt_do_table when I do
> SysRq-P. No call trace though.

Please post your ruleset and .config. A backtrace would also be
useful.

> Anyone else seeing it? Any ideas?

Works fine here. You could try if reverting one of these two patches
helps (second one only if its a SMP box).

ChangeSet@1.2010, 2005-03-09 20:28:17-08:00, bdschuym@pandora.be
   [NETFILTER]: Reduce call chain length in netfilter (take 2)

ChangeSet@1.1982.114.20, 2005-03-03 23:15:48+01:00, ak@suse.de
   [NETFILTER]: Reduce netfilter memory use on MP systems

Regards
Patrick
