Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFOSHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFOSHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:07:47 -0400
Received: from dsl-213-023-249-099.arcor-ip.net ([213.23.249.99]:18594 "EHLO
	pulsar.homelinux.net") by vger.kernel.org with ESMTP
	id S262593AbTFOSHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:07:41 -0400
Message-ID: <3EECB92A.5060603@pulsar.homelinux.net>
Date: Sun, 15 Jun 2003 20:21:30 +0200
From: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030516
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Return value of syscalls
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while debugging glibc-2.3.1 for cris-axis-linux-gnu, I encountered a 
discrepancy between code and comments explaining the return value of 
syscalls of the kernel (in glibc's source, architecture specific for 
cris). The comment says, values between -4095 and -1 (both inclusive) 
are considered to be an error. However, the code checks the return value 
to be greater or equal than -4096.

I'd like to fix that. But I need to know what's wrong, the code or the 
comment. So, what values indicate an error in linux's syscalls?

Best regards, Uwe

P.S.: A look in other architecture's source in glibc makes me thing the 
comment is right. I just want to make sure.

