Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUJVUvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUJVUvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUJVUvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:51:03 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27377 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267565AbUJVUst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:48:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Yynx0a9G1ajBG35xYhkFQe5d6bqDk4ACA5ByGLMPe2F0P206Rl46ZM4TD9WdLjJV7gmXIIYdbn7RcY/2NzTRgVLjH13iSl2hBXX1jhKF70y74escfhv0IaBn2KXDBoKNRADGG9jY3BUkoOrCWpMK/oI7Iyk+gx6OVlFhH7LMw+U=
Message-ID: <9e47339104102213472193a6df@mail.gmail.com>
Date: Fri, 22 Oct 2004 16:47:44 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Resolving missing external symbols at module load time.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at how to get rid of the inter_module_get calls in DRM to
AGP. What is the proper procedure to reference an external symbol that
may be any of the following:

1) compiled in
2) module that is loaded
3) non-existent since the system doesn't have the hardware

With inter_module_get() #1 and #2 would succeed and return a pointer
to the module. #3 would fail. The DRM code then handled each of these
cases. I've been looking at the new module calls and and I can't see
how to make this work.

The symbol resolution also needs to work if DRM is compiled in and the
system has no AGP support.

-- 
Jon Smirl
jonsmirl@gmail.com
