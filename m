Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131610AbQKKAbv>; Fri, 10 Nov 2000 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131782AbQKKAbl>; Fri, 10 Nov 2000 19:31:41 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13573 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131610AbQKKAbd>; Fri, 10 Nov 2000 19:31:33 -0500
Message-ID: <3A0C9277.273FA907@timpanogas.org>
Date: Fri, 10 Nov 2000 17:27:35 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
In-Reply-To: <3A0C427A.E015E58A@timpanogas.org> <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Ford wrote:

David,

We got to the bottom of it.  sendmail is using a BSD method to react to
load average which is different than what linux is providing.  You have
to crank up

O QueueLA = 18
O RefuseLA = 12 

on a busy Linux server since the defaults will result in large emails
never getting sent.  

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
