Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVAOCPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVAOCPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVAOCPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:15:51 -0500
Received: from host268.ipowerweb.com ([66.235.211.80]:34056 "HELO
	host268.ipowerweb.com") by vger.kernel.org with SMTP
	id S262115AbVAOCPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:15:16 -0500
Message-ID: <41E87CB1.30804@galaktika.ru>
Date: Fri, 14 Jan 2005 18:15:13 -0800
From: Nick <nick@galaktika.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can I ask a smbfs question here?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to use a W2K share from my laptop. This share is on Fat32 
(not sure if it matters). So far I am able either to configure it so it 
is mountable by non-root user or to configure it so it sees 
international (russian) characters in filenames on this share. I am on 
FC3 with the stock Samba (updated to samba-3.0.10-1.fc3). Here is what I 
did:

To make the share user mountable I changed the owner of the mountpoint 
to the regular user I am using, chmodded one of the binaries (sorry - do 
not remember which one - found its name in one of FAQs) and specified 
"users" option in the /etc/fstab for this share.  After all these I am 
able to mount this share as a regular user (owner of the mount point). 
Unfortunately, it cannot see russian characters in the file names.

To make russian characters visible, I added the following options to the 
/etc/fstab : codepage=cp866,iocharset=utf8. It works ONLY if I remove 
users (or user) option for the same share.

1) 
username=administrator,password=xxx,fmask=0666,codepage=cp866,iocharset=utf8 

This line allows me to see russian filenames but I cannot mount it as a 
regular user - only as root.

2) 
username=administrator,password=xxx,fmask=0666,codepage=cp866,iocharset=utf8,users 

I am getting the following message in /var/log/messages if I use the 
second line:
Jan  9 15:24:09 NS kernel: smbfs: Unrecognized mount option noexec
The share still mounts but the russian filenames are not visible 
(russian letters are replaced with question marks ???).

Any ideas if it is possible to fix this? I can "sudo mount" all the time 
but it does not sound right...

Thanks,
Nick


