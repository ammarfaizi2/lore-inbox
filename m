Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVLVPtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVLVPtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVLVPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:49:09 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:7485 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030206AbVLVPtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:49:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=qRRfOV4Ny8uNCSAR4TMQZElvPOdXqNXNsqkzY+atbl1qhI6ZmOo2v6DZUPHmJbC/CrFH9Ae4aKRZHL9bFUygHyvggfbN0ZRplLtM2/Q/rsufALplrjULbl86JWBAY5fZGzB4n4Cmw+xoim9t88+an7gS2ATUs1caBGjYseJoA+Q=
Message-ID: <43AACA82.5050305@gmail.com>
Date: Thu, 22 Dec 2005 17:47:14 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Question] LinuxThreads, setuid - Is there user mode hook?
Content-Type: text/plain; charset=ISO-8859-8-I; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am writing a provider that uses pthreads. The main program 
does not aware that the provider is using threads and it is 
not multithreaded.

After initialization the program setuid to nobody, the 
problem is that my threads remains in root id.

I read about discussions regarding LinuxThreads and figured 
out that I need to sync the uid,gid by my-self... :(

Is there a way in user mode to know when the process is 
setuid (some kind of callback)?

The best solution is to set this callback in every thread, 
so that it will setuid also when the main setuided.

Of course I can spawn a threads that pools the id of the 
main process... But there must be a better way to do that.

Best Regards,
Alon Bar-Lev.
