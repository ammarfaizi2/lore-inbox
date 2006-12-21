Return-Path: <linux-kernel-owner+w=401wt.eu-S1422800AbWLUNWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWLUNWx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWLUNWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:22:53 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:2905 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422800AbWLUNWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:22:52 -0500
Date: Thu, 21 Dec 2006 14:22:41 +0100
From: Erik Mouw <mouw@nl.linux.org>
To: Manish Regmi <regmi.manish@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Linux disk performance.
Message-ID: <20061221132241.GA15226@gateway.home>
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com> <1166431020.3365.931.camel@laptopd505.fenrus.org> <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com> <4589B92F.2030006@tmr.com> <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:48:42AM +0545, Manish Regmi wrote:
> Yes... my application does large amount of I/O. It actually writes
> video data received from ethernet(IP camera) to the disk using 128 K
> chunks.

Bursty video traffic is really an application that could take advantage
from the kernel buffering. Unless you want to reinvent the wheel and do
the buffering yourself (it is possible though, I've done it on IRIX).

BTW, why are you so keen on smooth-at-the-microlevel writeout? With
real time video applications it's only important not to drop frames.
How fast those frames will go to the disk isn't really an issue, as
long as you don't overflow the intermediate buffer.


Erik

-- 
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery
