Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTDNU2E (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbTDNU2D (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:28:03 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:21185 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263945AbTDNU2A (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:28:00 -0400
Message-ID: <3E9B1C8E.5030707@nortelnetworks.com>
Date: Mon, 14 Apr 2003 16:39:42 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
References: <002101c30239$fc0ae630$fe64a8c0@webserver> <8180000.1050330998@[10.10.2.4]> <20030414150759.GA14552@wind.cocodriloo.com> <11640000.1050332688@[10.10.2.4]> <b7etcd$s0n$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
 > Followup to:  <11640000.1050332688@[10.10.2.4]> By author:    "Martin J.
 > Bligh" <mbligh@aracnet.com> In newsgroup: linux.dev.kernel
 >
 >>> Martin, something which was not mentioned last week (I've just checked).
 >>>
 >>> It's OK if we never write to disk unless explicitely told, but will we
 >>> writeback when we munmap?

 > munmap() and fsync() or msync() will flush it to disk; there is no reason
 > munmap() should unless perhaps the file was opened O_SYNC.

Wait a minute.  Shouldn't a file opened O_SYNC flush the writes as they happen,
removing the requirement for any explicit syncing?  If it doesn't there are some 
very broken apps around.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

