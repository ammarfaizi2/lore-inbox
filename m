Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270568AbRHITq5>; Thu, 9 Aug 2001 15:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270571AbRHITqs>; Thu, 9 Aug 2001 15:46:48 -0400
Received: from runningman.mobilixnet.dk ([212.97.204.27]:50184 "EHLO
	runningman.mobilixnet.dk") by vger.kernel.org with ESMTP
	id <S270568AbRHITqi>; Thu, 9 Aug 2001 15:46:38 -0400
Date: Thu, 9 Aug 2001 21:46:45 +0200
From: Eirikur Hjartarson <eiki.hjartarson@wanadoo.dk>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac10
Message-ID: <20010809214645.A510@pluto.home>
Reply-To: eiki.hjartarson@wanadoo.dk
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010808195133.A22469@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 07:51:34PM +0100, Alan Cox wrote:
> ...
> o	Fix a bug in access() checks on X_OK with	(Christoph Hellwig)
> 	DAC ovveride

root can no longer execute files it does not have access to, e.g.

pluto -# id
uid=0(root) gid=0(root) groups=0(root)
pluto -# ls -l /sbin/getty
-r-x------    1 bin      bin         32784 Aug  8 06:54 /sbin/getty
pluto -# /sbin/getty
bash: /sbin/getty: Permission denied
pluto -# chmod go+rx /sbin/getty
pluto -# /sbin/getty
pluto -#

Regards,
-- 
Eiki
