Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTKJLKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 06:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTKJLKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 06:10:55 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:13501 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263172AbTKJLKy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 06:10:54 -0500
Message-ID: <3FAF7236.7020209@softhome.net>
Date: Mon, 10 Nov 2003 12:10:46 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com
Subject: net/packet/af_packet.c:{1057,1073}: flags vs. msg->flags
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

    [ I'm trying to cc: netdev - but they are not that welcome - and 
require subscription. I'm way too lazy (and my mail box is not that 
fast) to subscribe to send simple typo - if this is a case at all. ]

    [ kernel v2.6.0-test7 as found on lxr.linux.no, 2.4.{18,22} has the 
same - but line numbers are different. ]

    On line 1057 we have: "msg->msg_flags|=MSG_TRUNC;" to indicate that 
message was truncated.

    But on line 1073, where we make return status to user, we check 
against user suplied flags, but NOT msg->msg_flags.

    It looks like obvious typo.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  "... and for $64000 question, could you get yourself       |_|*|_|
    vaguely familiar with the notion of on-topic posting?"   |_|_|*|
                                 -- Al Viro @ LKML           |*|*|*|

