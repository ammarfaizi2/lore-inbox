Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbUKKEyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbUKKEyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUKKEyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:54:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:53677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262174AbUKKEyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:54:07 -0500
X-Authenticated: #21910825
Message-ID: <4192F069.90209@gmx.net>
Date: Thu, 11 Nov 2004 05:54:01 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Partitioned loop devices, support for 127 Partitions
 on SATA, IDE and SCSI
References: <419199A3.3050806@gmx.net> <cmsb12$pr1$1@sea.gmane.org>
In-Reply-To: <cmsb12$pr1$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov schrieb:
> Carl-Daniel Hailfinger wrote:
> 
> 
>>Hi,
>>
>>having seen the problems people have when switching from traditional IDE
>>drivers to libata if they have more than 15 partitions, I decided to do
>>something against it. With this patch (and recreating /dev/loop* nodes)
>>it is possible to support up to 127 partitions per loop device
>>regardless what the underlying device supports. It works for me
>>and has the added bonus that it will be in compatibility mode as long
>>as you don't specify the max_part parameter.
> 
> Why not just use EVMS? Partition code is supposed to be moved to userspace
> anyway.

Because my solution works fine with userspace partitioning code (I tested
with partx from util-linux) and has the big advantage that partitions
actually appear at the right place in /sys/block/loopN/loopNpM. Most
other solutions for many partitions per device failed to make the
relationship between parent device and partition visible in sysfs.
I haven't checked yet how EVMS handles this. Could you post
find /sys/block/$SOME_EVMS_DISK/ -type d
for a normal disk which is completely managed by EVMS so I can verify
whether that would be satisfactory. Thanks.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
