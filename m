Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVCTKkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVCTKkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVCTKkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:40:39 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:43183 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262125AbVCTKkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:40:36 -0500
Message-ID: <423D5322.5060200@lsrfire.ath.cx>
Date: Sun, 20 Mar 2005 11:40:34 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/5] Introduce proc_domode
References: <1111313683.EA21f.17773@neapel230.server4you.de> <Pine.LNX.4.61.0503201131510.4344@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503201131510.4344@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +#define MAXMODE		07777
> 
> 
> I think this should be 0777. SUID, SGID and sticky bit do not belong
> into /proc.

It's not /proc specific, the function proc_domode can be used for all
kinds of sysctls.  It enforces a maximum mode, specified in the ->extra1
member of a sysctl table entry.  In patches 2 and 5 you can see this
value is 0444 for all five new sysctls.

Rene
