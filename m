Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVGPRLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVGPRLo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVGPRLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:11:43 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:52199 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261710AbVGPRLn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:11:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nZV+sdFlQp2OmmpM9MOAf8Tcej8UMjrNO/bzb8oJ++eet+IM1GMVBUMmokLx4dhZ5bcLtGMJuKzDfV075mJO1NkTjxeE4k7wspdEpUi9nKyw2ViaFf9yAS5Nhb+Go6zkglD3XiV5Eqw1Y6oaC+gWpN38ZAJCgd72JWP70F84Pyo=
Message-ID: <699a19ea05071610115fcc827f@mail.gmail.com>
Date: Sat, 16 Jul 2005 22:41:42 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: compiling Kernel Modules with debugging information enabled
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
How can I compile a kernel module ,that is statically compiled at the
kernel compilation time, with debugging information.

To be more clear, say I have selected CONFIG_XFRM=y in .config file
I want to make a change such that net/xfrm/Makefile has an entry 
CFLAGS += -g so that it generates debugging information for all the
modules in that directory

I successfully did it for dynamically compiled modules that are insmod'ed.

How  can I do it for statically linked modules.

The idea is to do the following
objdump -DS xyz.o 
so that I know the source lines and their assembly translations.
This is useful in crashdump analysis where we get the information of 
<function name + offset>

S   Kartikeyan
