Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUBBLvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 06:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUBBLvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 06:51:24 -0500
Received: from keskus.netlab.hut.fi ([130.233.154.176]:42656 "EHLO
	keskus.netlab.hut.fi") by vger.kernel.org with ESMTP
	id S265359AbUBBLvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 06:51:24 -0500
Message-ID: <401E39B8.3080408@netlab.hut.fi>
Date: Mon, 02 Feb 2004 13:51:20 +0200
From: Emmanuel Guiton <emmanuel@netlab.hut.fi>
Reply-To: emmanuel@netlab.hut.fi
Organization: HUT Networking Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Handling sk_buff correctly.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm writing a module where I need to build and send a packet by hand. 
For this I properly (at least I hope so) fill a sk_buff structure and 
send it using NF_HOOK (seem to work fine, NF_HOOK returns 0). Sending 
one packet goes fine, sending several leads to kernel crashes. I think I 
don't handle correctly the release of the memory, but how should I do? I 
have no destructor function in my sk_buff, do I have to have one? (here, 
my attempts also lead to kernel crashes).

Bye,

         Emmanuel

