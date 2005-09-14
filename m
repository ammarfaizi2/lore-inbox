Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVINWUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVINWUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVINWUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:20:21 -0400
Received: from science.horizon.com ([192.35.100.1]:2882 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030223AbVINWUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:20:20 -0400
Date: 14 Sep 2005 18:20:03 -0400
Message-ID: <20050914222003.23790.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: NTP leap second question
Cc: george@mvista.com, johnstul@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The simplest way to achieve this is to:
a) Hack ntpd to "not notice" the leap-second announce bits 01 in
   the packet header and pretend they're actually 00.  This will
   make it not insert a leap second.
b) Run it with the -x flag so that it always slews the time.

The real solution would be to implement Markus Kuhn's UTS proposal
(http://www.cl.cam.ac.uk/~mgk25/uts.txt), which is about the most
reasonable meshing of the expectation that there are 86400
seconds per day with the fact that there are not.
