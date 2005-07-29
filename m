Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVG2FVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVG2FVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVG2FVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:21:30 -0400
Received: from mxb.rambler.ru ([81.19.66.30]:33802 "EHLO mxb.rambler.ru")
	by vger.kernel.org with ESMTP id S262350AbVG2FV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:21:28 -0400
Message-ID: <42EA2DF3.3020801@rambler.ru>
Date: Fri, 29 Jul 2005 09:24:03 -0400
From: Pavel Fedin <sonic_amiga@rambler.ru>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fsdevel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: NLS for HFS and "mount" tool.
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've got no reply so i resend this letter.
  Roman, i'd like to finish the work and would like to ask you what is 
wrong with your version of the NLS support for MacHFS. I expected it to 
appear in v 2.6.12 but there's no it. I would like to proceed basing on 
it if you insist.
  Also i would like to ask someone who is responsible for "mount" tool. 
I'd suggest to modify it in order to support several lines in fstab with 
the same device and mount points but different filesystems and options.
  For example:
/dev/cdrom /mnt/cdrom udf,iso9660 user,noauto,iocharset=koi8-r 0 0
/dev/cdrom /mnt/cdrom hfsplus user,noauto,nls=koi8-r 0 0
/dev/cdrom /mnt/cdrom hfs user,noauto,iocharset=koi8-r,codepage=10007 0 0
  Currently mount will stop at the first line and produce an error if 
the filesystem is not udf or iso (in the example). It will ignore the 
following lines.
  This would greatly improve handling of removable devices. Is there 
something (standards for example) which could prevent from this 
implementation?

-- 
  Kind regards, Pavel Fedin

