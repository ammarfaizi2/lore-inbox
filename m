Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUDNPkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 11:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUDNPkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 11:40:16 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:48771 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263664AbUDNPkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 11:40:05 -0400
Message-ID: <407D5B7F.107@myrealbox.com>
Date: Wed, 14 Apr 2004 08:40:47 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040410
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.5-bk]  'modules_install' failed to install modules 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I pulled the latest changesets just now and found this weird behavior:

'make' and 'make install' worked as expected, but 'make modules_install'
just deleted all the old modules, ran depmod, and then installed no new
modules -- nothing.

I finally found that doing another 'make' fixed whatever the problem
was and allowed modules_install to work properly the second time.

This happened on two different machines, so I'm fairly sure it wasn't
just me having a brainfart.

