Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932720AbVKZEia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932720AbVKZEia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 23:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVKZEia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 23:38:30 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:23078 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932720AbVKZEia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 23:38:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a+FOVAh7JLM0HkfRcU0YJWFhMHza3NBrZb8Qy79Zvu25jmxrJn3bCvgx2WrwgkcQnVBk+4/VX082zMohrEPancoyJ1Ni6ds+VFzYs9J9h4XCCqkVt4VzAbGpXOZmJ5fJk76yrzOtRo2OIPAwtNNYXV/z21uUp3/gxvHLcirJGks=
Message-ID: <2cd57c900511252038v4c378320t@mail.gmail.com>
Date: Sat, 26 Nov 2005 12:38:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Multimount block devices
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507221536360.30098@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0507221536360.30098@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/22, Jan Engelhardt <jengelh@linux01.gwdg.de>:
> Hi,
>
>
> I have got a block device which I would like to mount twice using different
> filesystems. The two filesystems support this (are already patched), but
> through the function thread of mounting comes open_bdev_excl() which makes
> it impossible to do said mounts.
>
> Can anyone give me a hint on what to change to disable bdev exclusive locking
> for a given condition? Thanks.

Write your own get_sb_bdev() and open_bdev(), do not call bd_claim().
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
