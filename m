Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUDQCPf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 22:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUDQCPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 22:15:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261273AbUDQCPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 22:15:33 -0400
Message-ID: <40809336.2060302@pobox.com>
Date: Fri, 16 Apr 2004 22:15:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
References: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bagalkote, Sreenivas wrote:
>>>ummmm what???    uxferaddr is u32.  why are you casting it to a pointer?
> 
> 
> Both copy_to_user and copy_from_user take pointers, don't they?


Yes, but consider on x86-64 a native pointer is _always_ 32-bit, 
therefore the interface is broken if it assumes the input pointer is 32 
bits.

	Jeff



