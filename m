Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWIASBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWIASBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbWIASBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:01:11 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:60174 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750705AbWIASBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:01:10 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: Oops after 30 days of uptime
Date: Fri, 1 Sep 2006 20:00:58 +0200
User-Agent: KMail/1.9.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200609011852.39572.linux@rainbow-software.org> <44F86732.5060501@trash.net>
In-Reply-To: <44F86732.5060501@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609012000.58873.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 19:00, Patrick McHardy wrote:
> Ondrej Zary wrote:
> > Hello,
> > my home router crashed after about a month. It does this sometimes but
> > this time I was able to capture the oops. Here is the result of running
> > ksymoops on it (took a photo of the screen and then manually converted to
> > plain-text). Does it look like a bug or something other?
> >
> >
> > Code;  c01eeb9e <init_or_cleanup+15e/160>
> > 00000000 <_EIP>:
> > Code;  c01eeb9e <init_or_cleanup+15e/160>   <=====
> >    0:   8b 5e 18                  mov    0x18(%esi),%ebx   <=====
> > Code;  c01eeba1 <ip_conntrack_protocol_register+1/70>
> >    3:   11 d8                     adc    %ebx,%eax
>
> This looks like a bug in some out of tree protocol module (2.4 only
> contains the built-in protocols). Did you apply any netfilter patches?


No patches, it's clean 2.4.31.
Hopefully I typed all the numbers correctly...

These network-related things are enabled:
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y

CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_POLICE=y


-- 
Ondrej Zary
