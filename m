Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVATV6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVATV6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVATV6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:58:14 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55785 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262018AbVATVyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:54:05 -0500
Message-ID: <41F02877.5010508@nortelnetworks.com>
Date: Thu, 20 Jan 2005 15:53:59 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug?]  strange behaviour with longjmp, itimer, and read/recv
 (but not pause)
References: <41F026E1.5050006@nortelnetworks.com>
In-Reply-To: <41F026E1.5050006@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:

> It this point I suspected my setjmp/longjmp code was bad, so to test it 
> I changed the recv() call to a pause() call.  After that change, 
> everything worked fine.  I changed it to a read() call, and it breaks 
> again with the third signal never being delivered.

My bad, didn't notice that pause() doesn't get restarted.  So the 
setjmp/longjmp code isn't being called with pause.

Also, behaviour is the same with 2.6.5 on a P4.

Chris
