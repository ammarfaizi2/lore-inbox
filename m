Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUFBMVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUFBMVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUFBMVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:21:05 -0400
Received: from [80.72.36.106] ([80.72.36.106]:54938 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262398AbUFBMTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:19:30 -0400
Date: Wed, 2 Jun 2004 14:19:23 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org, Al Piszcz <apiszcz@solarrain.com>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets
 over the network?
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
Message-ID: <Pine.LNX.4.58.0406021414120.802@alpha.polcom.net>
References: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As far as I understand devices in Linux, device file is only some kind of 
note to the *local* kernel that operations on that file is to be 
redirected to the device. It is always resolved by the local kernel and 
redirected to the local device (if tere is driver that claims this 
major/minor number). Life would be to simple...


Grzegorz Kulewski


On Wed, 2 Jun 2004, Piszcz, Justin Michael wrote:

> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
> 
> 6179737+0 records in
> 6179736+0 records out
> 
> Instead it treats it as a local block device?
> 
> Kernel 2.6.5.
