Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUGIKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUGIKgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUGIKgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:36:15 -0400
Received: from neptune.fsa.ucl.ac.be ([130.104.233.21]:51133 "EHLO
	neptune.fsa.ucl.ac.be") by vger.kernel.org with ESMTP
	id S265087AbUGIKgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:36:03 -0400
Message-ID: <40EE74A5.9030001@246tNt.com>
Date: Fri, 09 Jul 2004 12:34:13 +0200
From: Sylvain Munaut <tnt@246tnt.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harish K Harshan <harish@amritapuri.amrita.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupt Handling in linux
References: <40916.203.197.150.195.1089366068.squirrel@203.197.150.195>
In-Reply-To: <40916.203.197.150.195.1089366068.squirrel@203.197.150.195>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harish K Harshan wrote:

 > Hi.
 >
 > Can Interrupt handlers in linux, be interrupted by other running
 > processes??? to make it more clear, im developing a driver for and
 > ADC card, and would like to know if the CPU can or rather WILL
 > schedule wnother running process in the middle of the ISR, when a
 > timer interrupt comes in. If thats the case, then we need to use
 > spinlocks or other mechanisms in our ISR, right?? im new to this,
 > so if theres something not clear, it just just that my
 > understanding of this topic is not very deep.

If you share something between an ISR and a 'not' ISR, then you should
ensure proper locking.
Look at the "kernel-locking" DocBook in linux/Documentation/DocBook


Sylvain Munaut

