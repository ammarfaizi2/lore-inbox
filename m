Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267675AbUHPO6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUHPO6o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHPO6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:58:44 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:30164
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267681AbUHPO61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:58:27 -0400
Message-ID: <4120CB92.50102@bio.ifi.lmu.de>
Date: Mon, 16 Aug 2004 16:58:26 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, John Wendel <jwendel10@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net>	 <20040816143817.0de30197.Ballarin.Marc@gmx.de> <1092661385.20528.25.camel@localhost.localdomain>
In-Reply-To: <1092661385.20528.25.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

 >>This patch restores the behaviour of previous kernels, security issues included:
 >
 >
 > Like allowing any user to erase your drive firmware. What you could do
 > which is much more useful is printk the command byte that gets refused
 > and see if you can pin down what commands are being blocked that
 > are needed by K3B

growisofs from the dvd+rw tools doesn't work either with 2.6.8, not even
with suid bit set. So it seems that the 2.6.8.1 kernel keeps normal users
from writing CDs except when setting cdrecord suid, which I read on this
list would imply "some security bugs" (I don't know if that is true or not...)

But is that really the intention with 2.6.8.1 to give all programs for cd/dvd
writing the suid bit to allow users writing cds/dvds? (while even with
that at least k3b and growisofs fail at the moment)

At least this is a major change which I guess will make almost everyone
trying this kernel run into problems with cd writing :-(

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

