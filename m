Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVDJCgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVDJCgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 22:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVDJCgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 22:36:03 -0400
Received: from web54101.mail.yahoo.com ([206.190.37.236]:18108 "HELO
	web54101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261269AbVDJCfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 22:35:53 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=eKobBcnYzJAFgNNvebQU0piinwSpxh5G3eQE0JnuHo09IXxo+JiyqFQ8k03cM3sHqPZb8H8wyY6Oz3dXxi9I+conTSSW5WisH9oPXq8kZYfggBjzPLrVqGIt6cBY0Tjmekd2I0kL0MjSyM6caKygWKCtFOqthFS2cKAQ9ZLith4=  ;
Message-ID: <20050410023552.2545.qmail@web54101.mail.yahoo.com>
Date: Sat, 9 Apr 2005 19:35:52 -0700 (PDT)
From: sai narasimhamurthy <sai_narasi@yahoo.com>
Subject: increasing scsi_max_sg / max_segments for scsi writes/reads
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I had posted a question on increasing the scsi
read/write sectors  per command. I figured out some of
the things, but many questions still exist. 

I was wondering why the maximum writes I could get
from a single scsi write command could never exceed
204 
4096B  segments . I traced it to :  

static const int scsi_max_sg = PAGE_SIZE /
sizeof(struct scatterlist)

in scsi_merge.c .(which amounts to 204)  

Is this the limit of the maximum blocks we can
read/write through a single scsi command, atleast for
the given kernel (2.4.29) ? How can I increase
it??????

I am on a P3 Dell poweredgde 2400 . 

Sai 

  










__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
