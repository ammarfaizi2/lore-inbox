Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316882AbSFQKKS>; Mon, 17 Jun 2002 06:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSFQKKR>; Mon, 17 Jun 2002 06:10:17 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43760 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316882AbSFQKKQ>; Mon, 17 Jun 2002 06:10:16 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl> 
References: <UTC200206162041.g5GKfhn13251.aeb@smtp.cwi.nl> 
To: Andries.Brouwer@cwi.nl
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jun 2002 11:09:31 +0100
Message-ID: <20810.1024308571@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+int jffs2_prepare_follow_link(struct dentry *dentry, struct nameidata *nd,
+			      const char **llink, struct page **ppage)

+	nd->flags |= LOOKUP_KFREE_NEEDED;

Urgh. Don't do that on my behalf - we'll just switch to using 
page_follow_link, which to be honest I thought we'd already done -- there 
were definitely patches for it floating around.

--
dwmw2


