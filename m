Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWB1Xzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWB1Xzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWB1Xzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:55:32 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:59851 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932701AbWB1Xzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:55:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tL+oqXrFDQoe29SNvlYQSEbVM6R6KyoWBlJDewy2ZBYYdRll/zpwYH7mwThR+99e6RVTE2UjJSwpjt/0EzAWGUnnCBtUjGxxs9xSGmHgUoLeYRaLPJDIZdwoWA5mXy/8yxO9lr5BiQONKXDrKp4C0BgYqv4EIPNtwiQpZDE2u6g=
Message-ID: <41840b750602281555q493323c1y37d3d3fb25e3d087@mail.gmail.com>
Date: Wed, 1 Mar 2006 01:55:30 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Victor Porton,,," <porton@ex-code.com>
Subject: Re: Feature request: HDD status
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1FEESA-0002vG-00@porton.narod.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FEESA-0002vG-00@porton.narod.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Victor Porton,,, <porton@ex-code.com> wrote:
> Linux would be able (if this is possible for software) to
> deliver to the user the state of the HDD, whether it is
> active.
>
> I mean that Linux would have a module which would export to
> user space a boolean flag (probably a semaphore) which would
> be true while the HDD red lamp is shining and false while it
> is dark.

You can get a fair approximation of that information by monitoring
/proc/diskstats or the relevant counter files under /sys. Simply turn
on the logical LED if the IO counter has been incremented in the last
(say) 30ms. The only time this is likely to be noticable different
than the physical LED is when the drive is in some initialization
state or error condition.

For an amusing ready-made graphical version, try the gkhdplop plugin of gkrellm.

  Shem
