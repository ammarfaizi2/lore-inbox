Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUEaCDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUEaCDR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264505AbUEaCDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:03:17 -0400
Received: from ums.usu.ru ([194.226.236.116]:19145 "EHLO ums.usu.ru")
	by vger.kernel.org with ESMTP id S264501AbUEaCDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:03:12 -0400
Message-ID: <40BA92A8.8040405@ums.usu.ru>
Date: Mon, 31 May 2004 08:04:24 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Aliases are broken with ieee1394 modules
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem can be reproduced on a 2.6.6 kernel if you compile e.g. 
video1394 as a module.

The source line in drivers/ieee1394/video1394.c that is a problem:

MODULE_ALIAS_CHARDEV(IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_VIDEO1394 * 16);

The bad result is that in /lib/modules/2.6.6/modules.alias the following 
line appears:

alias char-major-171-1 * 16 video1394

I use gcc 3.3.2, if that matters. Similar problem exists with other 
ieee1394 modules.

-- 
Alexander E. Patrakov
Please CC: me, I am not subscribed
