Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWGMQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWGMQtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbWGMQtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:49:01 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:47101 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030243AbWGMQtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:49:00 -0400
Message-ID: <44B67961.4040600@oracle.com>
Date: Thu, 13 Jul 2006 09:48:33 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
CC: linux-aio@kvack.org, Xavier Roche <roche+kml2@exalead.com>,
       linux-kernel@vger.kernel.org
Subject: Re: io_submit() taking a long time to return ?
References: <44B5ED5F.1040606@exalead.com> <44B66A70.90502@oracle.com> <5d96567b0607130932g7ba6cf0jfebdb0af9c933000@mail.gmail.com>
In-Reply-To: <5d96567b0607130932g7ba6cf0jfebdb0af9c933000@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> what do u means by "sync block mapping " ?

To find out what blocks to issue async IO against the submission path
reads metadata from the file system that maps file regions to disk
blocks.  These metadata reads are synchronous and so can block the
submitting task.  The mappings tend to be cached, though, which is why
this doesn't seem to be a problem in practice.

- z
