Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQL2PL6>; Fri, 29 Dec 2000 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbQL2PLs>; Fri, 29 Dec 2000 10:11:48 -0500
Received: from host55.osagesoftware.com ([209.142.225.55]:52240 "EHLO
	netmax.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S130290AbQL2PLq>; Fri, 29 Dec 2000 10:11:46 -0500
Message-Id: <4.3.2.7.2.20001229092319.00c1eef0@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 29 Dec 2000 09:41:08 -0500
To: "Giacomo A. Catenazzi" <cate@student.ethz.ch>
From: David Relson <relson@osagesoftware.com>
Subject: Re: [PATCH] Processor autodetection (when configuring kernel)
Cc: linux-kernel@vger.kernel.org, linux-kbuild@torque.net
In-Reply-To: <4.3.2.7.2.20001229090753.00bc69a0@mail.osagesoftware.com>
In-Reply-To: <3A4C941E.EA824F87@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo,

Further experimentation has revealed another problem with the script.  The 
use of curly braces in the case statement, i.e.

      GenuineIntel:6:{8,9,11}    )  echo CONFIG_M686FXSR  ;;

does not work.  The construct below works, but I don't like it because of 
its length:

     GenuineIntel:6:8|GenuineIntel:6:9|GenuineIntel:6:11 	) echo 
CONFIG_M686FXSR  ;;


David
--------------------------------------------------------
David Relson                   Osage Software Systems, Inc.
relson@osagesoftware.com       Ann Arbor, MI 48103
www.osagesoftware.com          tel:  734.821.8800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
