Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSAVPlI>; Tue, 22 Jan 2002 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSAVPk5>; Tue, 22 Jan 2002 10:40:57 -0500
Received: from mons.uio.no ([129.240.130.14]:19421 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S287619AbSAVPku>;
	Tue, 22 Jan 2002 10:40:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15437.34809.615045.692374@charged.uio.no>
Date: Tue, 22 Jan 2002 16:40:41 +0100
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
In-Reply-To: <200201221523.g0MFNst03011@bliss.uni-koblenz.de>
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com>
	<200201221308.g0MD8EY16176@bliss.uni-koblenz.de>
	<E16T0ye-0002K6-00@charged.uio.no>
	<200201221523.g0MFNst03011@bliss.uni-koblenz.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rainer Krienke <krienke@uni-koblenz.de> writes:

     > Can somebody explain the major difference between both
     > solutions? Why did you Pete base your patch on 4 new major
     > device numbers whereas Andis patch did not need them? Are there
     > any major drawbacks involved not doing so?

Both Andi and Pete solve the problem of the limit on the number of
available reserved ports.

In addition, Pete fixes a second problem. There is a limit to the
number of 'unnamed' devices that the kernel can support (see the
function get_unnamed_dev()). Since each NFS mount 'eats' one such
device, this sets an upper limit of 255 simultaneous of NFS mounts
whether or not we have enough reserved ports.

Cheers,
   Trond
