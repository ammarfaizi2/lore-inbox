Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312993AbSDBXeR>; Tue, 2 Apr 2002 18:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312994AbSDBXeI>; Tue, 2 Apr 2002 18:34:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312993AbSDBXeC>; Tue, 2 Apr 2002 18:34:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: how to increase UNIX98 pty number?
Date: 2 Apr 2002 15:33:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a8df51$jjo$1@cesium.transmeta.com>
In-Reply-To: <OF391D2B4A.E68BC179-ON86256B8E.005D10CA@3com.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <OF391D2B4A.E68BC179-ON86256B8E.005D10CA@3com.com>
By author:    Hui_Ning@3com.com
In newsgroup: linux.dev.kernel
> 
> hi,
> 
> Where should I change to increase the UNIX98 pty number beyond 2048? The
> maximum allowed in xconfig is 2048.
> Is there any reason that this number can't go beyond 2048? Thanks,
> 

Yes, dev_t is too small.

You could hack the kernel to locally allocate additional major
numbers, preferrably in the 240-255 range, if you need it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
