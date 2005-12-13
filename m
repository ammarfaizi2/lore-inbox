Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVLMPcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVLMPcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLMPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:32:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:46051 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932120AbVLMPca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:32:30 -0500
Message-ID: <439EE986.20106@suse.de>
Date: Tue, 13 Dec 2005 16:32:22 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] uml/xen: make the vt subsystem a runtime option
References: <439EE38C.6020602@suse.de> <20051213152121.GA4335@infradead.org>
In-Reply-To: <20051213152121.GA4335@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Dec 13, 2005 at 04:06:52PM +0100, Gerd Knorr wrote:
>>  #ifdef CONFIG_VT
>> -	if (device == MKDEV(TTY_MAJOR,0)) {
>> +	if (console_use_vt && device == MKDEV(TTY_MAJOR,0)) {
> 
> You don't register a cdev for this one below, so this can't be reached.

It can be reached in uml kernels.  Unless the vt subsystem is enabled 
the uml kernel registeres a uml-specific tty driver with major #5 (see 
arch/um/drivers/stdio_console.c).

cheers,

   Gerd
