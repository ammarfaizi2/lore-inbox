Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWERXM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWERXM6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWERXM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:12:58 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:8871 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751163AbWERXM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:12:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=j2FV2Ot429hSLRIpqAirgI4OvYdK0RNeW/nMQoYBnzdcP1KJADZyfGEF3r8fowrV1cVTK/3+LnqiBfHbjC3EcTEJLB33lO7p/pFe0pZ13oAwgehtuQAndz2iBVrIh+xGJctOZssJXnHVNBdfou8MynpscJ9dcIe5NO/WltvvUqk=
Message-ID: <446CFF77.9050008@gmail.com>
Date: Fri, 19 May 2006 08:12:55 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Jan Wagner <jwagner@kurp.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <446BD8F2.10509@gmail.com> <446C9492.2040704@garzik.org>
In-Reply-To: <446C9492.2040704@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> One thing to think about before supporting streaming from/to harddisks 
>> from userland is how to make data flow efficiently from userland to 
>> kernel and back.  But, no matter what, kernel <-> userland usually 
>> involves one data copy, so I don't think making sg similarly efficient 
>> would be too difficult (it might be already).
> 
> Actually, the kernel usually maps userland pages, eliminating the need 
> for a copy.  write(2) may have copied data into that page originally, 
> but mmap(2) need not have.

Yeap, to achieve high streaming rate, it would be best to have 
preallocated ring buffer and ring pointers.  If this high-bw streaming 
thing becomes common, we can add it to sg, I guess.

-- 
tejun
