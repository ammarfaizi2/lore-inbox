Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUHDNXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUHDNXY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUHDNXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:23:23 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:57228 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265398AbUHDNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:23:16 -0400
Message-ID: <4110D529.4000605@myrealbox.com>
Date: Wed, 04 Aug 2004 05:23:05 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>, hirofumi@mail.parknet.co.jp
Subject: Re: [2.6.8-rc2-bk] New read/write bug in FAT fs
References: <4110CF29.8060401@myrealbox.com>
In-Reply-To: <4110CF29.8060401@myrealbox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:

> Even when a fat32 fs is mounted read-write I now get error
> messages claiming the fs is 'read-only' when I try to write
> to it.

Okay, I've now found the comments about specifying values
for iocharset and codepage, and read-write works again.

However, IMHO the 'mount' command should simply refuse to
mount a FATfs read/write unless iocharset and codepage are
specified.  As things stand now, 'mount' reports the fs is
mounted rw when it simply is not true.

