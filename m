Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLEKcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 05:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTLEKcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 05:32:43 -0500
Received: from 062016131079.customer.alfanett.no ([62.16.131.79]:64654 "EHLO
	shogun.thule.no") by vger.kernel.org with ESMTP id S263591AbTLEKcm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 05:32:42 -0500
Message-ID: <3FD05E9C.5080501@thule.no>
Date: Fri, 05 Dec 2003 11:31:56 +0100
From: Troels Walsted Hansen <troels@thule.no>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: High-pitch noise with 2.6.0-test11
References: <1070605910.4867.9.camel@idefix.homelinux.org>
In-Reply-To: <1070605910.4867.9.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin wrote:
> I just installed 2.6.0-test11 on my Dell Latitude D600 (Pentium-M)
> laptop and I noticed a strange high-pitch noise comming from the laptop
> itself (that wasn't there with 2.4). The noise happens only when the CPU
> is idle. Also, I have noticed that removing thermal.o makes the noise
> stop, which is very odd. Is there anything that can be done about that?

I had the same problem with my Dell Latitude C600 and newer kernels with 
  HZ>100. The solution I found was to add "apm=idle-threshold=100" to 
the kernel commandline, to disable APM idle calls.

You should monitor the temperature of your laptop to make sure it 
doesn't spin wildly and create extra heat if you use the same solution.

Using ACPI instead of APM might also be a solution?

Troels

