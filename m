Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVC2ND2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVC2ND2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 08:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVC2ND2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 08:03:28 -0500
Received: from vine.secline.com.br ([200.160.121.36]:43718 "HELO
	smtp.secline.com.br") by vger.kernel.org with SMTP id S262251AbVC2NDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 08:03:23 -0500
Message-ID: <42495221.4000408@secline.com.br>
Date: Tue, 29 Mar 2005 10:03:29 -0300
From: Leo <leo@secline.com.br>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smbmount char problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All:

I have a problem mounting a Win2k Server shared folder in linux.

mount -t smbfs -o username=leo,codepage=cp850,iocharset=iso8859-1 
//<servername/d$ /mnt/pt

The part is mounted successfully after having entered a password.

The problem is that several accented characters (not all of them) appear 
incorrectly.

AFAIK Á, ã, õ appear as A, a, o when listed.

á,é, í, ó, ú , à .. ù, ç all appear correctly.

When listing files explicitly that contain the incorrect characters an 
error message like _file not found_ is returned (logical since in fact 
the files is named differently)

The real kicker is that smbclient's ftp-like interface displays the 
characters correctly. 

the kernel (2.6.11-r5 on gentoo) uses iso-8859-1 as it's default nls 
character set though the smbfs module doesn't define a default nls for 
itself.

I've already tried cp860  (same results)

I've already sent a message to the samba boys and I was refered to you 
good folk.

Any suggestions?

Thanks in advance,

Leo
