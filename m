Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267751AbUJGSgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267751AbUJGSgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUJGSf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:35:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:40167 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267720AbUJGSds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:33:48 -0400
Message-ID: <41658C03.6000503@nortelnetworks.com>
Date: Thu, 07 Oct 2004 12:33:39 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hzhong@cisco.com
CC: "'Jean-Sebastien Trottier'" <jst1@email.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'David S. Miller'" <davem@redhat.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
In-Reply-To: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:

> It was my original proposal. The only question is to return which error
> code. We cannot return EAGAIN as Posix explicitly disallows it. Is EIO good?
> Or some other new error code?

Since we wouldn't be posix compliant anyway in the nonblocking case, we may as 
well return EAGAIN--it's the most appropriate.

Chris
