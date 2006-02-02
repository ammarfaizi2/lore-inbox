Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWBBPxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBBPxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWBBPxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:53:02 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:54158 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932088AbWBBPxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:53:01 -0500
Message-ID: <43E22B2D.1040607@openvz.org>
Date: Thu, 02 Feb 2006 18:54:21 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, serue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: [RFC][PATCH] VPIDs: Virtualization of PIDs (OpenVZ approach)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC][PATCH] VPIDs: Virtualization of PIDs (OpenVZ approach)

OpenVZ project would like to present another approach for VPIDs 
developed by Alexey Kuznetsov. These patches were heavily tested and 
used for half a year in OpenVZ already.

OpenVZ VPIDs serves the same purpose of VPS (container) checkpointing 
and restore. OpenVZ VPS checkpointing code will be released soon.

These VPIDs patches look less intrusive than IBM's, so I would ask to 
consider it for inclusion. Other projects can benefit from this code as 
well.

Patch set consists of 7 patches.
The main patches are:
- diff-vpids-macro, which introduces pid access interface
- diff-vpids-core, which introduces pid translations where required 
using new interfaces
- diff-vpids-virt, which introduces virtual pids handling in pid.c and 
pid mappings for VPSs

Patches are against latest 2.6.16-rc1-git6

Kirill Korotaev,
OpenVZ team

