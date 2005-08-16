Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbVHPVm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVHPVm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHPVm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:42:56 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:23574 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932463AbVHPVm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:42:56 -0400
Message-ID: <43025DD7.3090007@vmware.com>
Date: Tue, 16 Aug 2005 14:42:47 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: asm/segment.h?
References: <83B69EC3-8677-4199-BDDB-375AE708234C@freescale.com>
In-Reply-To: <83B69EC3-8677-4199-BDDB-375AE708234C@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Aug 2005 21:42:27.0600 (UTC) FILETIME=[65813100:01C5A2AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala wrote:

> Looking at some architectures it appears that asm/uaccess.h should be  
> used instead of asm/segment.h.  Is this generally true that code in  
> segment.h should be moved into uaccess.h or is it still valid for an  
> architecture to have segment.h?


At least in i386, segment.h can be included by userspace programs, and 
although it really is the user include maintainers that should sort that 
out, moving segment.h into uaccess.h makes that job more tedious.

It looks like the proper thing to do for ppc is to deprecate segment.h 
entirely.

Zach
