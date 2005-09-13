Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVIMGkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVIMGkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVIMGkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:40:51 -0400
Received: from smtpout.mac.com ([17.250.248.73]:62182 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932377AbVIMGku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:40:50 -0400
Mime-Version: 1.0 (Apple Message framework v734)
In-Reply-To: <6789B04A-198A-4C08-9F95-BFDBCD2C0660@mac.com>
References: <6789B04A-198A-4C08-9F95-BFDBCD2C0660@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5DD26C79-AE0B-4314-A3FC-8DBE65935420@mac.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Kernel ABI headers step #1: Gathering information
Date: Tue, 13 Sep 2005 02:40:24 -0400
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The script I posted contained a semi-bug such that if someone didn't  
capture
standard error, they would be missing the GCC version in the log.   
Here's a
fixed version (Thanks to Keith Owens for pointing this out!)

Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are, by
definition, not smart enough to debug it.
   -- Brian Kernighan


#! /bin/sh
echo "Linux kernel version:"
uname -a
echo
echo
echo "GCC version:"
gcc -v 2>&1
echo
echo
echo "GCC predefined macros:"
echo | gcc -E - -dM | sort


