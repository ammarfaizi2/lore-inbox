Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263045AbSJRFDB>; Fri, 18 Oct 2002 01:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263152AbSJRFDB>; Fri, 18 Oct 2002 01:03:01 -0400
Received: from moe.rice.edu ([128.42.5.4]:19161 "EHLO moe.rice.edu")
	by vger.kernel.org with ESMTP id <S263045AbSJRFDA>;
	Fri, 18 Oct 2002 01:03:00 -0400
Message-ID: <004301c27664$9d224070$7e0c2a80@OMIT>
From: "omit_ECE" <omit@rice.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Double & Integral don't match
Date: Fri, 18 Oct 2002 00:10:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In tcp_input.c, I declare a variable,
double t_owd_; 
t_owd_ = rcv_tsecr - rcv_tsval;

But in this case, the right side in the equation are integrals,
which is against to the left side of double.
I tried, 
t_owd_ = (double) rcv_tsecr - (double) rcv_tsval;

It didn't work. How could I do to make it?
Thank you.

YuZen
