Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbTISB60 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 21:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTISB60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 21:58:26 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:32417
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id S262258AbTISB6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 21:58:25 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: linux-kernel@vger.kernel.org
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F6A61E9.1060407@klozoff.com>
Date: Thu, 18 Sep 2003 21:54:49 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vmalloc and DMA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to treat a large number of pages (about 128) as continuous.  However, I 
need to DMA to that memory from a device.  The device has a built-in 
scatter-gather feature, so I don't need to worry about whether the pages are 
physically contiguous.  Looking through LXR revealed a  function called 
vmalloc_32.  My questions are these:

(1) Is vmalloc_32 going to stick around for a while?
(2) Is it appropriate to vmalloc_32(512<<10) and then grab the underlying 
addresses for DMA?
(3) If it *is* appropriate, what's the proper way to get to those underlying 
addresses? I saw a virt_to_page macro somewhere...


-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE


