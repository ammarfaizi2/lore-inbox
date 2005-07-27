Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVG0Tmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVG0Tmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVG0Tmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:42:38 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:52745 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S262392AbVG0Tma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:42:30 -0400
Message-ID: <42E7E398.7000308@highlandsun.com>
Date: Wed, 27 Jul 2005 12:42:16 -0700
From: Howard Chu <hyc@highlandsun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b2) Gecko/20050621
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 network slowdown?
References: <1122452018.772579.63900@g49g2000cwa.googlegroups.com>	<20050727082020.C73AC5F7CA@attila.bofh.it>	<42E7497B.5040202@highlandsun.com> <20050727105506.78b82aaa@dxpl.pdx.osdl.net>
In-Reply-To: <20050727105506.78b82aaa@dxpl.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Wed, 27 Jul 2005 01:44:43 -0700
> Howard Chu <hyc@highlandsun.com> wrote:
>> I just recently compiled the 2.6.12.3 kernel for my x86_64 machine
>> (Asus A8V motherboard); was previously running a SuSE-compiled 2.6.8
>> kernel (SuSE 9.2 distro). I'm now seeing extremely slow throughput on
>> the onboard Yukon (Marvell) ethernet interface, but only in certain
>> conditions. Going back to the 2.6.8 kernel shows no slowdown.

> There a couple of possibilities, one is driver differences. SUSE ships
> the SysKonnect vendor driver vs the older version in 2.6.12, and the
> TCP congestion and TSO code has changed since 2.6.8.

Thanks for that tip. The SuSE 2.6.8 kernel had driver version 7.04, the 
2.6.12.3 kernel had driver version 6.23. I just downloaded the current 
driver from www.syskonnect.de (8.23) and installed it and now things are 
much improved, getting around 6.8MB/sec throughput.

-- 
   -- Howard Chu
   Chief Architect, Symas Corp.  http://www.symas.com
   Director, Highland Sun        http://highlandsun.com/hyc
   OpenLDAP Core Team            http://www.openldap.org/project/
