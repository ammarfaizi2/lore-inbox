Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265272AbSJXG4v>; Thu, 24 Oct 2002 02:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265330AbSJXG4v>; Thu, 24 Oct 2002 02:56:51 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:64225 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265272AbSJXG4u>; Thu, 24 Oct 2002 02:56:50 -0400
Date: Thu, 24 Oct 2002 12:36:21 +0530 (IST)
From: "T.L.Madhu" <madhu.tarikere@wipro.com>
To: linux-kernel@vger.kernel.org
Subject: Unexpected behaviour with create_module
Message-ID: <Pine.SV4.4.21.0210241234430.9751-100000@wipro.wipsys.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

create_module() system calls gives segmentation fault with 
size (second) argument set to huge value. This behaviour is 
seen only in 2.4.* series kernel but the same call in 2.5.*
series (tested with 2.5.43 kernel) fails as EXPECTED with 
errno set to ENOMEM.

Check this programme,
----------------------------------------------------------
#include <linux/module.h>
#include <errno.h>
        
main()
{
	printf("Return values for too big module size %d ",
		create_module("dummy", 99999999));
	printf("errno %d\n", errno);
}
----------------------------------------------------------

Is this a known bug? wondering why this bug is not fixed in
2.4.* series?

Please let me know.

Thanks,
Madhu





