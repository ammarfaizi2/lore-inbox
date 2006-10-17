Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161139AbWJQKS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbWJQKS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWJQKS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:18:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:32065 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161139AbWJQKS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:18:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JJMrqrG+Ojz5o4N1PX+4za8sENidL3ks6+NwTdQ+cwoLl9LRgUtzCr/lW4ogCiA7jkHy8GFhuNpL766Ni0kabznkU9RJoSIx2wLEXz74+3QouyVcGygDiMgTPNV0SDoeTn58MQcE70CJEnnFVWG+NU/rNkqzaEZB1GKW6qA905c=
Message-ID: <d0bd1c10610170318x5dac0620l8842c43430ac33b@mail.gmail.com>
Date: Tue, 17 Oct 2006 18:18:25 +0800
From: "Kay Tiong Khoo" <kaytiong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: stopping a process during a timer interrupt
In-Reply-To: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d0bd1c10610170311s3ef77226n1d645f3f1e178753@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a timer interrupt, I tried to stop the current process by changing
it's run state to TASK_STOPPED via set_current_state(TASK_STOPPED).
However, this results in a system hang.

I can't find a way to stop the current process during an interrupt
context. Does such code exist in the kernel? If not, how does one go
about implementing it from within a kernel module.

Thanks.
Kay Tiong
