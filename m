Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422884AbWJSDmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWJSDmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 23:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423240AbWJSDmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 23:42:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:39289 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422884AbWJSDmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 23:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=oXzmCmKXbaKXtobmgV7Elo6iASbcIuGn9DxRF/dmh8g4gLQgo4lpUfxhcD4B85YdwrKn53QhwKqhqjKjtohp0PCDeQbJz2YBHGJqc2nb9YRcW9a5y4/7W7MlNvpljKKiqkWV2ekdQURsE3JzseoOiAmfRmtjaBU9Dr+fBCJVaTE=
In-Reply-To: <45363AA1.1070604@stud.feec.vutbr.cz>
References: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com> <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com> <45363AA1.1070604@stud.feec.vutbr.cz>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <08F249B5-AED0-42EF-8B61-1B3AFAF1747C@gmail.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kay Tiong Khoo <kaytiong@gmail.com>
Subject: Re: stopping a process during a timer interrupt
Date: Thu, 19 Oct 2006 11:42:31 +0800
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's true. But if you are writing a profiler, the current process  
is the process of interest in the interrupt context.

Kay Tiong

On Oct 18, 2006, at 10:30 PM, Michal Schmidt wrote:

> Kay Tiong Khoo skrev:
>> On a timer interrupt, I tried to stop the current process by changing
>> it's run state to TASK_STOPPED via set_current_state(TASK_STOPPED).
>> However, this results in a system hang.
>> I can't find a way to stop the current process during an interrupt
>> context. Does such code exist in the kernel? If not, how does one go
>> about implementing it from within a kernel module.
>
> In interrupt context there's no "current process" by definition.
>
> Michal

