Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTLGSFx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGSFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:05:10 -0500
Received: from mail.g-housing.de ([62.75.136.201]:21667 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264476AbTLGSFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:05:02 -0500
Message-ID: <3FD35DBD.9070004@g-house.de>
Date: Sun, 07 Dec 2003 18:05:01 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031203 Thunderbird/0.4RC2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Benecke <jens-usenet@spamfreemail.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Help: 2.4 -> 2.6 (test11,bk2) kernel module file size (due to
 debug options?)
References: <bqs6rq$vv3$1@sea.gmane.org>
In-Reply-To: <bqs6rq$vv3$1@sea.gmane.org>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Benecke wrote:
> Hi,
> 
> after installing (actually - creating a debian package for) 2.6.0-test11-bk2
> I have this:
> 
> 2.3M    /boot
> 366M    /lib/modules/2.6.0-test11-bk2                           !!!
> 15k     /usr/share/doc/kernel-image-2.6.0-test11-bk2

you don't use "du -cahL" when counting /lib/modules/2.6.0-test11-bk2, 
don you? /lib/modules/2.6.0-test11-bk2/build is a symbolic link to your 
kernel sources, "-L" in "du" counts them too. (man du)

evil@sheep:~$ du -cahL /lib/modules/2.6.0-test11/ | tail -n1
422M    total
evil@sheep:~$ du -cah /lib/modules/2.6.0-test11/ | tail -n1
2.2M    total


Christian.
-- 
BOFH excuse #265:

The mouse escaped.
