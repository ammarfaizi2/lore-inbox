Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWJRObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWJRObM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWJRObM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:31:12 -0400
Received: from mx0.karneval.cz ([81.27.192.122]:38157 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1160999AbWJRObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:31:11 -0400
Message-ID: <45363AA1.1070604@stud.feec.vutbr.cz>
Date: Wed, 18 Oct 2006 16:30:57 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: IceDove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Kay Tiong Khoo <kaytiong@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: stopping a process during a timer interrupt
References: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com> <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com>
In-Reply-To: <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Tiong Khoo skrev:
> On a timer interrupt, I tried to stop the current process by changing
> it's run state to TASK_STOPPED via set_current_state(TASK_STOPPED).
> However, this results in a system hang.
> 
> I can't find a way to stop the current process during an interrupt
> context. Does such code exist in the kernel? If not, how does one go
> about implementing it from within a kernel module.

In interrupt context there's no "current process" by definition.

Michal
