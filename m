Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTDCUCe 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263578AbTDCUCe 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:02:34 -0500
Received: from siaag1ae.compuserve.com ([149.174.40.7]:46769 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S263577AbTDCUBJ 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 15:01:09 -0500
Date: Thu, 3 Apr 2003 15:10:45 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: RAID 5 performance problems
To: "Jonathan Vardy" <jonathan@explainerdc.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304031512_MC3-1-32E0-8338@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Tos be certain that this was not the bottleneck, I removed it
>from the raid so that is runs in degraded mode. This did not
>change the performance much


Don't do that and expect a valid performance test.

On average, one-fifth of all array reads will cause reads from all four
remaining disks in order to reconstruct the missing data when you run
in that mode.

--
Chuck
