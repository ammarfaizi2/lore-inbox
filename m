Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUIWAff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUIWAff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUIWAff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:35:35 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:37394 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265800AbUIWAfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:35:31 -0400
Message-ID: <516c87e80409221735b1b6a92@mail.gmail.com>
Date: Thu, 23 Sep 2004 08:35:31 +0800
From: Long Pu <long.pu@gmail.com>
Reply-To: Long Pu <long.pu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why is clear_user_highpage necessary in do_anonymous_page()?
In-Reply-To: <516c87e8040922022973701fff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <516c87e8040922022973701fff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I wonder why clear_user_highpage is necessary if we don't concern security.
When we write  to a anonymous page the very first time, we don't care
whatever the original contents of that page is. And
clear_user_highpage() takes a lot of cpu time under certain workload
such as compiling kernel.

 Is there any reason I don't know to reserve it?
