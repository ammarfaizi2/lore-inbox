Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUJKMiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUJKMiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUJKMgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:36:44 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:14986 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268890AbUJKMfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:35:55 -0400
Message-ID: <416A7E25.8050101@kolivas.org>
Date: Mon, 11 Oct 2004 22:35:49 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ankit Jain <ankitjain1580@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: Difference in priority
References: <20041011121726.10979.qmail@web52903.mail.yahoo.com>
In-Reply-To: <20041011121726.10979.qmail@web52903.mail.yahoo.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ankit Jain wrote:
> hi
> 
> if somebody knows the difference b/w /PRI of both
> these commands because both give different results
> 
> ps -Al
> & 
> top
> 
> as per priority rule we can set priority upto 0-99 
> 
> but top never shows this high priority

Priority values 0-99 are real time ones and 100-139 are normal 
scheduling ones. RT scheduling does not change dynamic priority while 
running wheras normal scheduling does (between 100-139). top shows the 
value of the current dynamic priority in the PRI column as the current 
dynamic priority-100. If you have a real time task in top it shows as a 
-ve value. ps -Al seems to show the current dynamic priority+60.

Con
