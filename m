Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269288AbUJFPOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269288AbUJFPOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJFPOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:14:21 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:1233 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269288AbUJFPNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:13:50 -0400
Message-ID: <41640B87.6000501@nortelnetworks.com>
Date: Wed, 06 Oct 2004 09:13:11 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: Joris van Rantwijk <joris@eljakim.nl>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net>
In-Reply-To: <20041006080104.76f862e6.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
> Joris van Rantwijk <joris@eljakim.nl> wrote:
> 
> 
>>My understanding of POSIX is limited, but it seems to me that a read call
>>must never block after select just said that it's ok to read from the
>>descriptor. So any such behaviour would be a kernel bug.
> 
> 
> There is no such guarentee.

Hmm, the man page for select() says:

"Those  listed  in readfds will be watched to see if characters become available 
for reading (more precisely, to see if a read will not block"

Maybe it needs changing?

Chris
