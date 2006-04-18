Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWDRHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWDRHMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDRHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 03:12:36 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:48322 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751003AbWDRHMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 03:12:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VilBR7xCmtuuYoCqRRzGJKWl5Lfv4j2+n8hPNpLR719jZBpmHtmaOdAJTFCowlbMC2swiKetPBw40vO/g3I2eMFYx24vvjn0UMbND47oIjq6v0P4Db6BpmklpsEKyqbmD49QYIGo1t1KK14QVPUc7xXT4RViOKiTqMbuJE5/y8A=
Message-ID: <bf3792800604180012s4c96fae2g3725f52690af9a0d@mail.gmail.com>
Date: Tue, 18 Apr 2006 15:12:35 +0800
From: "Liu haixiang" <liu.haixiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on Schedule and Preemption
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Now I am developing drivers on Linux 2.6.

My problem is that from time to time, I will get log meesage from
kernel: "scheduling while atomic ..." and the stack will be dumped by
the kernel.

Then I investigate the code in sched.c but don't understand. Anybody
can clarify this piece of code for me?

if (likely(!current->exit_state)) {
	if (unlikely(in_atomic())) {
		printk(KERN_ERR "scheduling while atomic: "
			"%s/0x%08x/%d\n",
			current->comm, preempt_count(), current->pid);
		dump_stack();
	}
}

Thanks a lot

Haixiang
