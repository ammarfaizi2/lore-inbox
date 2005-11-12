Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVKLAqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVKLAqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKLAqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:46:34 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:29413 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750814AbVKLAqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:46:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=H4Vvdy0vHo77S12lvSEvKO2zCwuGIWT5561BY3GYm/Uzk7WGzj6XxyPeajOjW6gzWSZKBVRc/eemmMmLxaZ1J1q/3yRY20GT8nnA9jZgIYenC4hV6xOiDBgMb9xSUnIluBPax7Sn1s683/oSQeKqCjC711F1FrGV07VZRGKT0u4=
Message-ID: <43753B45.4040409@pol.net>
Date: Sat, 12 Nov 2005 08:45:57 +0800
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	 <6bffcb0e0511111432m771dcda2y@mail.gmail.com>	 <20051111150108.265b2d3f.akpm@osdl.org> <6bffcb0e0511111530t55bb1decq@mail.gmail.com>
In-Reply-To: <6bffcb0e0511111530t55bb1decq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: "Antonino A. Daplas" <adaplas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:

> 
> fbset recognise my gpu as NV32. lspci show it as NV34 (0000:01:00.0
> VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200]
> (rev a1)
> ). According to
> http://download.nvidia.com/Windows/45.23/NVIDIA_Driver_Release_Notes_v45.23.pdf
> it should be NV34.

This is okay, I think.  The id assigned by nvidia and the id derived by
nvidiafb may not match.  nvidiafb derives it from the pci device id (the 2nd
and 3rd nibble).  Since your chipset's id is 0x0322, it prints out as NV32.

Tony
