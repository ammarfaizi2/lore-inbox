Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269979AbUJHOCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269979AbUJHOCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269982AbUJHOCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:02:09 -0400
Received: from mail5.iserv.net ([204.177.184.155]:62096 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S269979AbUJHOCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:02:07 -0400
Message-ID: <41669DE0.9050005@didntduck.org>
Date: Fri, 08 Oct 2004 10:02:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside
 kernel
References: <20041008130442.GE5551@lkcl.net>
In-Reply-To: <20041008130442.GE5551@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> could someone kindly advise me on the location of some example code in
> the kernel which calls one of the userspace system calls from inside the
> kernel?
> 
> alternatively if this has never been considered before, please could
> someone advise me as to how it might be achieved?

What are you trying to do?  In most cases needing to use syscalls from 
within the kernel is an indication of a design flaw.  The most common 
case is loading firmware, which should use request_firmware() instead.

--
				Brian Gerst
