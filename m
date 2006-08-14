Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWHNTpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWHNTpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWHNTpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 15:45:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15967 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751618AbWHNTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 15:45:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SNuIoniDoZJ1AcmbHUEOSp4zgc+MXvbO8OFepVxdLQVrY0xID2qvowqkS8xynZc8a1k9HH3yqDxIirVa5yF1d1tKHivJzJsT/GZJ7zZIUKULQqz/zX3G0Ul+UTIbdcqP6QSPqrMkShK4bXz49NE7KL7kJ4qs2jzhA2C8IgT9ClU=
Message-ID: <44E0D2D5.80004@gmail.com>
Date: Mon, 14 Aug 2006 21:45:02 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Reinaldo Carvalho <reinaldoc@gmail.com>
CC: Hulin Thibaud <hulin.thibaud@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com>	 <44E08C50.5070904@wanadoo.fr> <4a5881460608140752t1e1f7157xaff450e2f16d7f9@mail.gmail.com>
In-Reply-To: <4a5881460608140752t1e1f7157xaff450e2f16d7f9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reinaldo Carvalho wrote:
> Try build-in LVM driver.
> 
> Device Drivers  --->
> Multi-device support (RAID and LVM)  --->
> [*] Multiple devices driver support (RAID and LVM)
> [*]   Device mapper support

He might try, but this won't resolve his issue. He needs to activate LVM volume 
in userspace (by rc.sysinit et. al.) before root contained on that volume can be 
mounted. This has to be done by init ram disk.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
