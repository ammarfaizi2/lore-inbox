Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWJJQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWJJQJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWJJQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:09:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35660 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932183AbWJJQJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:09:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ictNwQ1X33MzlbE+iFR35iElJ65QeYyux3U1BzpOJREcOUdZFCR1bwdFagdN8RnqvNfTBaMmJk53P2wOK9TxEqr39kWV9C2WiZ1oJykTKuwRPFIeCqBG1BXgGOAXiaH+s7LYsANK/NC0HBC9skvBZ/QlVgPq/F1BdmzZ69SQ71w=
Message-ID: <6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
Date: Tue, 10 Oct 2006 18:09:31 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061010000928.9d2d519a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
>

This looks strange
ps aux | grep t3
root      4305 81.6  0.1   5952  2596 pts/7    R+   17:54   2:44
python ./rt-tester.py t3-l1-pi-steal.tst
michal    4351  0.0  0.0   3908   760 pts/5    R+   17:58   0:00 grep t3
[michal@euridica ~]$ ps aux | grep creat
root      3934 87.3  0.0   1652   496 pts/4    R    17:25  28:37 creat05
michal    4353  0.0  0.0   3912   772 pts/5    S+   17:58   0:00 grep creat

python ./rt-tester.py t3-l1-pi-steal.tst and creat05 (from LTP) are
always in running state (creat05 since 28 minutes). I don't have any
idea why this happens.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
