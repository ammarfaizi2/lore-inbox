Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272885AbTHFMcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273016AbTHFMcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:32:21 -0400
Received: from sea2-f12.sea2.hotmail.com ([207.68.165.12]:30982 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S272885AbTHFMcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:32:20 -0400
X-Originating-IP: [194.7.240.2]
X-Originating-Email: [lode_leroy@hotmail.com]
From: "lode leroy" <lode_leroy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 lockup while write()ing to /dev/hda1
Date: Wed, 06 Aug 2003 14:32:19 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
X-OriginalArrivalTime: 06 Aug 2003 12:32:19.0542 (UTC) FILETIME=[C7127F60:01C35C16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to report a problem I saw on linux 2.5.70:
(since I have a workaround, I do not intend to debug this further)

the following program locks up the computer.
sometimes this has happened after about 16MB,
sometimes after about 64MB...

main()
{
    int f = open("/dev/hda1", O_RDWR);
    char buffer[8192];
    for(i=0;1;i++) {
       printf("%d\r", i);
       write(f, buffer, sizeof(buffer);
       /* fsync(f); */
    }
    close(f)
}

when using adding the fsync(), all goes fine!

_________________________________________________________________
Receive your Hotmail & Messenger messages on your mobile phone with MSN 
Mobile http://www.msn.be/gsm/smsservices

