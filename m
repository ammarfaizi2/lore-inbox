Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVIVIfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVIVIfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVIVIfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:35:09 -0400
Received: from [194.90.79.130] ([194.90.79.130]:40710 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751450AbVIVIfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:35:08 -0400
Message-ID: <43326CB3.8080607@argo.co.il>
Date: Thu, 22 Sep 2005 11:34:59 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karthik Sarangan <karthiks@cdac.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT for block device
References: <4332697C.7070409@cdac.in>
In-Reply-To: <4332697C.7070409@cdac.in>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 08:35:04.0280 (UTC) FILETIME=[87936580:01C5BF50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karthik Sarangan wrote:

> I have a scsi hdd configured at /dev/sdb.
>
> open("/dev/sdb", O_DIRECT) succeeds.
> A 'read' or 'write' returns -1 and errno is EINVAL.
>
> How to read and write data to it? They do not seem to work. I have a 
> 262144 byte buffer for data transfer.

make sure your buffer is aligned on a 512 byte boundary.
