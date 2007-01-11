Return-Path: <linux-kernel-owner+w=401wt.eu-S1750774AbXAKQIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbXAKQIk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAKQIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:08:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:37916 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbXAKQIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:08:40 -0500
Message-ID: <45A66106.5030608@qumranet.com>
Date: Thu, 11 Jan 2007 18:08:38 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: kvm & dyntick
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It occurs to me that kvm could benefit greatly from dyntick:

dyntick-enabled host:
 - generate virtual interrupts at whatever HZ the guest programs its 
timers, be it 100, 250, 1000 or whatever
 - avoid expensive vmexits due to useless timer interrupts

dyntick-enabled guest:
 - reduce the load on the host when the guest is idling
   (currently an idle guest consumes a few percent cpu)

What are the current plans wrt dyntick?  Is it planned for 2.6.21?

-- 
error compiling committee.c: too many arguments to function

