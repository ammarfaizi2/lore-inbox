Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271755AbRICROP>; Mon, 3 Sep 2001 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271757AbRICROF>; Mon, 3 Sep 2001 13:14:05 -0400
Received: from t2.redhat.com ([199.183.24.243]:22006 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271755AbRICRNp>; Mon, 3 Sep 2001 13:13:45 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B93B95E.F30F1F8B@loewe-komp.de> 
In-Reply-To: <3B93B95E.F30F1F8B@loewe-komp.de>  <m3zo8cp93a.fsf@belphigor.mcnaught.org> <01090310483100.26387@faldara> <32526.999534512@redhat.com> 
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 18:14:01 +0100
Message-ID: <6951.999537241@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pwaechtler@loewe-komp.de said:
>  Because historically the 'D' meant "wait on _D_isk" 8-)

Waiting uninterruptibly on a local device is somewhat saner than waiting
uninterruptibly on a network server. If you ignore the cases where we end up
in D state waiting for a removable medium which has been removed, of course.

These days, disk technology is sufficiently complex that the cop-out of 
saying "nothing will ever go wrong, let's not bother to implement the 
cleanup code" is probably no longer appropriate even there.

--
dwmw2


