Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWDSOzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWDSOzw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWDSOzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:55:52 -0400
Received: from wproxy.gmail.com ([64.233.184.227]:2167 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbWDSOzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:55:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c7di0e6qnI/1pDk8+x/sQaQ6IOSDZft5+b/kL+riy75/LxzuQ+3p4cmj8ETICdqmj3pXN6izxQm1u5vLcU0PCA5o0H30DOmLsd8ZfDPV2hriFgF1O+qcmshtiq26sFrBVKN3wQG2XyLNHCkVwQcnIco9viYS2pquigAD7IuTAVk=
Message-ID: <44464F73.5050902@gmail.com>
Date: Wed, 19 Apr 2006 10:55:47 -0400
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Antti Halonen <antti.halonen@secgo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: searching exported symbols from modules
References: <963E9E15184E2648A8BBE83CF91F5FAF436197@titanium.secgo.net> <Pine.LNX.4.61.0604190846280.27438@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604190846280.27438@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>
> `insmod` (or modprobe) does all this automatically


only modprobe does dependency loading.



soekris:~# rmmod scx200_gpio scx200
soekris:~#
soekris:~# insmod scx200_gpio
insmod: can't read 'scx200_gpio': No such file or directory
soekris:~#
soekris:~# modprobe scx200_gpio
[  237.848000] scx200: NatSemi SCx200 Driver
[  238.344000] scx200: GPIO base 0x6100
[  238.356000] scx200: Configuration Block base 0x6000

soekris:~# lsmod
Module                  Size  Used by
scx200_gpio             4292  0
scx200                  4912  1 scx200_gpio

