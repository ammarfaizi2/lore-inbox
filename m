Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbTHZL5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 07:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTHZL5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 07:57:42 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:49753 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S263616AbTHZL5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 07:57:41 -0400
Date: Tue, 26 Aug 2003 13:57:39 +0200
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] linux-2.4.22 Oops on ATM PCA-200EPC
Message-ID: <20030826115739.GA9450@oceanic.wsisiz.edu.pl>
References: <Pine.LNX.4.53.0308260104580.17995@oceanic.wsisiz.edu.pl> <200308261112.h7QBCVNv020928@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308261112.h7QBCVNv020928@ginger.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 07:12:33AM -0400, chas williams wrote:
> >I have always used vanilla kernel with very old patch for ATM
> >(name: linux-2.3.99-pre6-fore200e-0.2f.patch) It worked well -
> >trouble-free. 
> >I have just tried vanilla 2.4.22, here is oops. ATM doesn't work :(
> 
> what did you do to get this crash?  just startup an interface?
> is clip built as a module?

During startup or restart interface by script

[...]
        if is_yes "$CLIP" ; then
                msg_starting "ATM CLIP"
                daemon atmarpd -b
                for i in $interfaces_atm_boot ; do
                        run_cmd -a "$(nls 'Bringing up interface') $i" /sbin/ifup $i
 boot
[...]


[root@voices linux]# cat .config |grep ATM |grep -v "#"
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_NET_SCH_ATM=y
CONFIG_ATM_NICSTAR=m
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_FORE200E_MAYBE=m
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_FORE200E=m

[root@voices linux]# lsmod
nicstar                28984   7  (autoclean)
suni                    4740   0  (autoclean) [nicstar]


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
