Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWIPA0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWIPA0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWIPA0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:26:18 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:30894 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932250AbWIPA0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:26:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oVvnOG9RukMxrceqEJdsh6og1Xh0J6LXCOX3GrMEOqyh+59Sxy3NOX9w6+wWXP6SH6NvD0+pC6Xx4NGFlTzrl2e0FMUTqwSXap0bDbBQxBehjua8xct0L3/s6Rf4tSyMDNQ5mugxm3z0d/5FV0otGljeQP8W8APn8Eyvl4ZQtVg=
Message-ID: <653402b90609151726l230e9bafg5d06a36e7cd7b32c@mail.gmail.com>
Date: Sat, 16 Sep 2006 02:26:16 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: jim@gibbons.com
Subject: Re: request for ioctl range for private devices
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450B31BF.4050604@gibbons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <450B31BF.4050604@gibbons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/06, Jim Gibbons <jim@gibbons.com> wrote:
>
> I would like to use an ioctl range that would be safe, now and in the
> future.  Given that we won't be putting this driver on any general
> computing platforms, it seems inappropriate to reserve an ioctl range
> for this device.
>

I'm trying to get a patch accepted, and I just modified the file to
appear in the ioctl-number list, so if they apply the patch, the magic
number will be automatically reserved.

I think it's the right approach. Anyway, you should write and send the
device driver first, for review, because some people disagree with
your ioctl use, and maybe they can ask you for use another way to
communicate special commands to your device.

If you are not going to submit the driver code ever, I think it will
be much more difficult to get a ioctl just for your private use. If
I'm right, you will have to keep your patch update on your own, as it
doesn't belong to linux at all.

      Miguel Ojeda
