Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDQVHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbTDQVHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:07:39 -0400
Received: from mail.hks.com ([63.125.197.5]:27024 "EHLO mail.hks.com")
	by vger.kernel.org with ESMTP id S261710AbTDQVHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:07:38 -0400
Subject: context switch code question
From: Robert Schweikert <Robert.Schweikert@abaqus.com>
To: linux-kernel@vger.kernel.org
Cc: Robert Schweikert <rjschwei@abaqus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: ABAQUS
Message-Id: <1050614372.2227.161.camel@cheetah.hks.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Apr 2003 17:19:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone please point me to the context switching code. I am
interested in the context switch structure and the values that are
saved. I am chasing a weird problem with some numerical code that uses
mmx instructions to get flush to zero to work. Specifically I am calling
the

_MM_SET_FLUSH_TO_ZERO_MODE

macro which in turn ends up calling _mm_setcsr(), wherever that might be
implemented.

What I am trying to figure out is a.) is this register value properly
set/reset during context switch and b.) is this particular register
properly transfered when the process gets moved to another CPU. 

I assume that this is a configurable option in the kernel since PII and
Pentium do not have this instruction, and thus it could just be that my
kernel is not configured correctly.

I tried to find this type of info without posting but failed.

Thanks,
Robert
-- 
Robert Schweikert <Robert.Schweikert@abaqus.com>
ABAQUS
