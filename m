Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281063AbRKKOfd>; Sun, 11 Nov 2001 09:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281064AbRKKOfX>; Sun, 11 Nov 2001 09:35:23 -0500
Received: from smtp-rt-8.wanadoo.fr ([193.252.19.51]:27088 "EHLO
	lantana.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281063AbRKKOfL>; Sun, 11 Nov 2001 09:35:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: tasklets and finalization
Date: Sun, 11 Nov 2001 15:34:46 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E162vh8-0000E9-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!  In the driver I'm working on, a tasklet is scheduled
from time to time.  Are there any guarantees as to when
it will run?  I'm worried, for example, about module
unloading: how to be sure that the scheduled tasklet runs
before the module is unloaded?

Thanks,

Duncan.

PS: My first thought was to use tasklet_kill, but according
to "Linux device drivers" (2nd ed) that may hang if the
tasklet isn't pending.

PPS: Another thought was to call schedule(), hoping that
all pending asklets will get run then, but is that reliable?
