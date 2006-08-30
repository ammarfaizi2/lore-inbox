Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWH3PlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWH3PlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 11:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWH3PlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 11:41:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5385 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751073AbWH3PlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 11:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XDNeNnGdSmN1OtL8vDiqa/MkJe0mZhJrMx4af5K86oKpThknwzBFRb+y8cBcJL7dVmZ6LKnpkWTLyL3z5Uf52qqtOfDf3lfskYQZCeuym2Y9YNlK4w4dYWmypWkpclU/sXOY1GapbZXaqyjTv1U+tU0KmqgAKff59DQXepep+Uc=
Message-ID: <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
Date: Wed, 30 Aug 2006 21:11:12 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Martin Ohlin" <martin.ohlin@control.lth.se>
Subject: Re: A nice CPU resource controller
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44F5AB45.8030109@control.lth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44F5AB45.8030109@control.lth.se>
X-Google-Sender-Auth: 863ad8da953d3b5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/06, Martin Ohlin <martin.ohlin@control.lth.se> wrote:
> To those interested
>
> I have been working on a CPU resource controller using the nice value as
> a control signal. At the moment, the control is done on a
> per-task-level, but I have plans to extend it to groups of tasks. The
> control is based on a PI-controller (Proportional, Integral), using an
> execution time measurement as input to the controller, and the output
> from the controller as nice value.
>

The CKRM e-series is a PID based CPU Controller. It did a good job of
controlling and smoothing out the load (and variations) and even
worked with groups. But it achieved all this through some amount of
complexity. How do you plan to extend the idea to groups? Do you have
any code that we can look at?

I do not understand controlling the nice value? Most cpu control the
bandwidth/time - are there any advantages to controlling the nice
value? How does this interplay with dynamic priorities that the
scheduler currently maintains?

> Using the controller, it is possible to make CPU reservations that in a
> soft way guarante that tasks achieve as much resources as the
> corresponding reference indicates.
>
> For those interested, the concept is described in more detail along with
> experiments in the first part of my thesis available at:
> http://www.control.lth.se/database/publications/article.pike?artkey=ohlin06lic

Read one more paper - time

Balbir
