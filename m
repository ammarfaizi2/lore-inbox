Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbRE0Xsl>; Sun, 27 May 2001 19:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbRE0Xsb>; Sun, 27 May 2001 19:48:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13327 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262877AbRE0Xs3>; Sun, 27 May 2001 19:48:29 -0400
Subject: Re: [CHECKER] user-pointer bugs in 2.4.4 and 2.4.4-ac8
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Mon, 28 May 2001 00:45:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200105242112.OAA29801@csl.Stanford.EDU> from "Dawson Engler" at May 24, 2001 02:12:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154AE6-0002Ux-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:64:do_ioctl: ERROR:PARAM:62:64: tainted var 'pDivaConfig' (from line 62) used as arg 0 to 'DivasCardConfig'
> 	switch (command)

Yep - fixed

> [BUG]supposed to at least be bad form.
> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:186:do_ioctl: ERROR:PARAM:184:186: tainted var 'mem_block' (from line 184) used as arg 0 to 'DivasGetMem'
> 			return 0;

Yep - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:131:do_ioctl: ERROR:PARAM:129:131: tainted var 'pDivaLog' (from line 129) used as arg 0 to 'DivasLog'

Yep - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:172:do_ioctl: ERROR:PARAM:142:172: tainted var 'arg' (from line 142) used as arg 0 to 'DivasGetList'

Yep.

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:268:ipddp_ioctl: ERROR:PARAM:268:268: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_find_route'
>         {

Ok fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/isdn/eicon/linchr.c:97:do_ioctl: ERROR:PARAM:95:97: Deref tainted var 'pDivaStart' (tainted from line 95)

Real - fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:265:ipddp_ioctl: ERROR:PARAM:268:265: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_create'

Fixed

> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/net/appletalk/ipddp.c:273:ipddp_ioctl: ERROR:PARAM:268:273: tainted var 'rt' (from line 268) used as arg 0 to 'ipddp_delete'

Fixed

>                 case SIOCFINDIPDDPRT:
> Start --->
>                         if(copy_to_user(rt, ipddp_find_route(rt), sizeof(struct ipddp_route)))
>                                 return -EFAULT;

Fixed

> [BUG]  seems pretty confused.
> /u2/engler/mc/oses/linux/2.4.4-ac8/net/decnet/af_decnet.c:1491:__dn_getsockopt: ERROR:PARAM:1438:1491: Deref tainted var 'optlen' (tainted from line 1438)
> 	struct linkinfo_dn link;
> 	unsigned int r_len;

Fixed

> 	case PHONE_CAPABILITIES_CHECK:
> Error --->
> 		retval = capabilities_check(j, (struct phone_capability *) arg);
> 		break;

Fixed

All look valid to me

