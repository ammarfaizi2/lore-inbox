Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292336AbSCONmO>; Fri, 15 Mar 2002 08:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292339AbSCONmF>; Fri, 15 Mar 2002 08:42:05 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:3082 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S292336AbSCONlv>; Fri, 15 Mar 2002 08:41:51 -0500
Date: Fri, 15 Mar 2002 08:41:49 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: Miao Qingjun <qjmiao@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel IXP1200 and Linux
Message-Id: <20020315084149.0fcdbf68.fryman@cc.gatech.edu>
In-Reply-To: <20020315053916.531.qmail@web12303.mail.yahoo.com>
In-Reply-To: <20020315053916.531.qmail@web12303.mail.yahoo.com>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have problems to run linux from IXA SDK 2.01 onto
> an old IXP1200 evaluation board (not IXM1200 board).

this is your problem.  SDK 2.01 contains the kernel reworked for the
RadiSys board ("bridalveil/SI").  the original EVB with dual gigF 
and 8x 10/100TX doesn't work with this source.

use the source instead from the netwinder.org site with the original
intel IXP1200 how-to information.  (also, getting support on LKML for
the unofficial patches to make IXP1200 work isn't too likely :) 
you'll note that the kernel is pre-2.4.0.  ancient history. these
patches have not been incorporated in the main kernel...)

the SDK 2.x series is commented for the changes made from the 
original how-to release, and massaging #ifdef's in the code _should_
fix it, but seems not to.  i haven't done an exhaustive diff to see
where else changes have been made.

-josh
