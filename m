Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270800AbUJUSwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbUJUSwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbUJUSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:49:58 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:47084 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S270814AbUJUSnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:43:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=L0n5S/v/1QNcu0H9ac/xgE89uVLXfGOp0bvU5u5y3nCSHNl91742bNZeJo7hAX5rukHX3tt+Gxf3TrJHKqQJt7GdQ2YPCGW1YjkxMDwaqSfuS0ijlyV19vb1Zl4BRP3XivHAtJtNcnNwoOgKsWugndPQprSkC4TleiOxSydLvyE=
Message-ID: <7798951e041021114322d34e82@mail.gmail.com>
Date: Thu, 21 Oct 2004 13:43:46 -0500
From: Troy McFerrron <hotdogday@gmail.com>
Reply-To: Troy McFerrron <hotdogday@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 + SMT + MPEG transcoding = Hardlock?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.6.9-rc1 came around, I tried it and had hardlocks with the SMT
scheduler enabled. 2.6.9-rc2 had the same issue.

2.6.9 rc-3 fixed the issue.

2.6.9 "stable" brought it back.

It mainly manifests itself when using transcode to encode vobs to
MPEG. It doesn't happen with 2.6.8.1, 2.6.9-rc3, but does happen with
everything between and after. (Though I didn't try RC-4. I was happy
with RC3.)

When I say hardlock, I mean hardlock. No reponse from the system at
all. If audio is playing, it loops.

Are there specific changes I could roll back in 2.6.9 to make it
viable and stable on ym system? I'm not willing to give up SMT, but
want to keep my kernel current. Can anyone reproduce these lockups?

-- 
Troy McFerron
Kernel Ricer and Linux Hobbyist.
