Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUHZGjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUHZGjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 02:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHZGjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 02:39:18 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:33412
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267701AbUHZGjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 02:39:12 -0400
Message-ID: <412D858E.10404@bio.ifi.lmu.de>
Date: Thu, 26 Aug 2004 08:39:10 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Broadbent <markb@wetlettuce.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
References: <412C5E80.8050603@bio.ifi.lmu.de>	 <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>	 <412CA518.7090109@bio.ifi.lmu.de> <1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
In-Reply-To: <1093448839.25506.57.camel@mbpc.signal.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Broadbent wrote:

> Stupid question but the MAC addresses on the cards are different aren't
> they?  Could you also double check that the xid values differ on both
> machines, this is shown on the line:
> 
> IP-Config: eth0 UP (able=1, xid=07196018)
>                                 ^^^^^^^^
> 
> Both MAC and xid should be different.

obiously, the problem is here. The xid is the same on 5 different hosts
I tested with the debugging-enabled kernel. Looking it ipconfig.c I now
understand that with several hosts using the same xid it must go wrong.
I'm currently compiling a new kernel with debugging enabled in rancom.c
to see what's going wrong here. Looks like random_bytes is returning
the same value on all hosts :-(

Can anyone else maybe do a quick check with "ip=dhcp" on two hosts
just to see if the problem with the identical xids just show up here?

I will send the result of the debugging output from random.c.

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

