Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUARMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUARMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:43:25 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:20232 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S261784AbUARMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:43:24 -0500
Message-ID: <400A7F55.9060209@snapgear.com>
Date: Sun, 18 Jan 2004 22:43:01 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org, henrique.gobbi@cyclades.com,
       support@stallion.oz.au, R.E.Wolff@BitWizard.nl, paulus@samba.org,
       elfert@de.ibm.com, felfert@millenux.com, kuba@mareimbrium.org
Subject: Re: [2/3]
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113173352.D7256@flint.arm.linux.org.uk>
In-Reply-To: <20040113173352.D7256@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

Russell King wrote:
> Here are patches to drivers in the 2.6 kernel which have not been tested
> to correct the tiocmset/tiocmget problem.
> 
> You can find the full thread at the following URL:
> 
> http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&threadm=1dvnl-5Pr-1%40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DISO-8859-1%26q%3DOutstanding%2Bfixups%26btnG%3DGoogle%2BSearch%26meta%3Dgroup%253Dlinux.kernel

Looks good for mcfserial.c. The only additional change I would
make is to remove the "rts", "dtr", and "val" variables from the
ioctl function - removing the TIOCM* cases means these variables
are no longer used.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

