Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVJTNMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVJTNMw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVJTNMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:12:52 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:193 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932129AbVJTNMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:12:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r4Xhtr4cgrZhyO4eF6JyX2xckMwPioVbyKbuTmEgxz6Tsq9HG3fdpEc4oiEui165LAujEP6Nc8nvfpxePM1RL/FoNDI0cf7J3MpAlyCPVj1GKK9/uxPL4IGSGo3EAcci3sBQRKsUMhbIM1yEK0wzaQYYOOHSHyNlvvnU254BTg4=
Message-ID: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
Date: Thu, 20 Oct 2005 18:42:50 +0530
From: Block Device <blockdevice@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Increase priority of a workqueue thread ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am using a custom workqueue thread in my module. How do I increase the
priority of the workqueue threads ?
I've seen that each workqueue contains an array of per-cpu structures
which has a
task_struct of the thread on a particular cpu. Since these threads are
created from keventd
I think they'll have the same priority as keventd.  Also the per-cpu
structure is something which is private to the workqueue
implementation. Directly using it (from my driver) to increase the
priority of the workqueue doesnt seem correct to me. Is there any
interface or standard way of changing the priority of a workqueue.

Thanks
BD
