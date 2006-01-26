Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWAZEDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWAZEDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 23:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWAZEDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 23:03:03 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:4024 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWAZEDA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 23:03:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DoLTOYwXiBqnvzuNmzSCSNrneHwn3iwjbd5HluFcJHIcXPeyINQoN5s4jTWmSAlbt5oFl7xZeZwzxrIKURawJRZIQAt+2UhfQSXWBQ/mp4IvMxCA54IljHm0XwIZfy5AcXbuFIpk61vaIq8Dw8MHilXdSYjYD0I5SrtL60gMfcs=
Message-ID: <93564eb70601252002x5949b65fs@mail.gmail.com>
Date: Thu, 26 Jan 2006 13:02:58 +0900
From: Samuel Masham <samuel.masham@gmail.com>
To: davids@webmaster.com
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Cc: lkml@rtr.ca, Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
In-Reply-To: <93564eb70601251949r1fb4c209t@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D8386B.6000204@rtr.ca>
	 <MDEHLPKNGKAHNMBLJOLKGEJPJKAB.davids@webmaster.com>
	 <93564eb70601251949r1fb4c209t@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/06, Samuel Masham <samuel.masham@gmail.com> wrote:
> comment:
> As a rt person I don't like the idea of scheduler bounce so the way
> round seems to be have the mutex lock acquiring work on a FIFO like
> basis.

which is obviously wrong...

Howeve my basic point stands but needs to be clarified a bit:

I think I can print non-compliant if the mutex acquisition doesn't
respect the higher priority of the waiter over the current process
even if the mutex is "available".

OK?
