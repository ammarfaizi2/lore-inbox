Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269687AbUISGms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269687AbUISGms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 02:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269713AbUISGms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 02:42:48 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:16850 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S269687AbUISGmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 02:42:46 -0400
Message-ID: <414D2A65.4080605@blueyonder.co.uk>
Date: Sun, 19 Sep 2004 07:42:45 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc2-bk4 Unknown symbol __VMALLOC_RESERVE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2004 06:43:11.0022 (UTC) FILETIME=[EE2584E0:01C49E13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M wrote:
 > Hello,
 >
 > After testing 2.6.9-rc2-bk4 today, I am getting the following error 
when I
 > attempt to load my Nvidia module:
 >
 > Sep 18 15:31:36 poseidon kernel: nvidia: module license 'NVIDIA' taints
 > kernel.
 > Sep 18 15:31:36 poseidon kernel: nvidia: Unknown symbol __VMALLOC_RESERVE

There is a recent post with details of what's needed for the nvidia 
driver to compile and work. Links to patched are included. For that one, 
put as the first line in nv.c
unsigned int __VMALLOC_RESERVE;

There is also the need to add "PM_SAVE_STATE, /* save device's state */" 
to included/linux/pm.h after PM_RESUME line and a previous patch to nv.c 
that's been around a few weeks now.
Regards
Sid.
-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
