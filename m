Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSKYV6h>; Mon, 25 Nov 2002 16:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265711AbSKYV6h>; Mon, 25 Nov 2002 16:58:37 -0500
Received: from c3po.aoltw.net ([64.236.137.25]:2965 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id <S265708AbSKYV6h>;
	Mon, 25 Nov 2002 16:58:37 -0500
Message-ID: <3DE29EB9.9050301@netscape.com>
Date: Mon, 25 Nov 2002 14:05:45 -0800
From: jgmyers@netscape.com (John Myers)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [rfc] new poll callback'd wake up hell ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi writes:
 > 1) Move the wake_up() call done inside the poll callback outside the lock

You can't.  You need to hold the lock over the callback or your callback 
could end up accessing a freed epitem.


