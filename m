Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbREQSqj>; Thu, 17 May 2001 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbREQSq3>; Thu, 17 May 2001 14:46:29 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:1686 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261483AbREQSqV>; Thu, 17 May 2001 14:46:21 -0400
Date: Thu, 17 May 2001 20:46:16 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac10
Message-ID: <20010517204616.K754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E150QuA-0005ah-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 17, 2001 at 05:45:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 05:45:38PM +0100, Alan Cox wrote:
> 2.4.4-ac10

I think someone forgot this little return. It removes the
following warning:

serial.c:4208: warning: control reaches end of non-void function


--- linux-2.4.4-ac10/drivers/char/serial.c	Thu May 17 20:41:05 2001
+++ linux-2.4.4-ac10-ioe/drivers/char/serial.c	Thu May 17 20:35:53 2001
@@ -4205,6 +4205,7 @@
 {
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/10);
+   return 0;
 }
 
 /*

Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
