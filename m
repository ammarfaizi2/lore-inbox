Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVKQXFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVKQXFg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKQXFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:05:35 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:43224 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964914AbVKQXFf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:05:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jqkVgoD/NfEAh3rlZfTWJ4Wb5Qw6CzDy+GI5oTHZdPa3RmUfG7zfLMQE6FrW+E5N+YEbZEOyg10jkDswu9EK3XF7xnsxt/kKHzzY4irvSDGGBHuJB68ZM1b8mIn2YRNpfz2O+8+/4QVxKfhFO8GAMTHKM88cpUYFznhiR4EQYPw=
Message-ID: <4ae3c140511171505j33dc4c2ere731f1b3c55f9741@mail.gmail.com>
Date: Thu, 17 Nov 2005 18:05:34 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: workqueue is not working?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to schedule some work in an softirq handler. The way I did is
as follows:

I use create_workqueue to initialize a workqueue "vrpciod_workqueue",

in the softirq, I do INIT_WORK(work, func, data), and then
queue_work(vrpciod_workqueue, work);

I think func() should be called a bit later. However, I noticed that
func() is never called by the workqueue. I don't know why.

Can soneone give me some suggestions? Many thanks!

Xin
