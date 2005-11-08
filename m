Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbVKHSVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbVKHSVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVKHSVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:21:49 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:6897 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965112AbVKHSVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:21:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=JEP/0czs5ioQjojc1Z9MdElWVfSZkgXp0FeViQJD8D+faaq3DbLyV2bmsm1FmYDTh2ranetrDQFjOFn+fvKRKDrPQzInPGMsOMi5FsvdcMbHZnalbhaflmGTDBUuxey3D4iL4xS9MdwmFJSi6ozYRwdVbAsvfmLaJzCQchiXB+0=
Date: Tue, 8 Nov 2005 21:35:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] DocBook: allow to mark structure members private
Message-ID: <20051108183511.GA12043@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Ahoy.  Excellent.  Compare my personal todo list item:

> 35.for kernel-doc: make some fields :private: so that a description is not
>     expected for them.

Aha! A kernel-doc hacker! Randy, by any chance, do you have "support for
nested structs" in your TODO? And if yes, what's the status? I have
parsing with the following syntax:

 # /**
 #  * struct my_struct - short description
 #  * @a: first member
 #  * @b: second member
+#  * @c: nested struct
+#  * @c.p: first member of nested struct
+#  * @c.q: second member of nested struct
 #  * 
 #  * Longer description
 #  */
 # struct my_struct {
 #     int a;
 #     int b;
+#     struct her_struct {
+#         char **p;
+#         short q;
+#     } c;
 # };

But properly nested displaying is in pretty much nil state since .. uh
crap.. summer.

