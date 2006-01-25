Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWAYJIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWAYJIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWAYJIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:08:50 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:469 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750849AbWAYJIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:08:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TnwT9Rj6kYz3Wue/uAfUc63rojw/QkbfFArIsA0STIGPxKCqmqvNhWUgMA2pyYqHNMzic+0e5blNn7ySd1hIFAaDJrtCGMi8FFa3O/Bu6vQwUcGdFIUjZsTRkx6vjNYXDEpuU8kTZoGL3NcD1QYX+EItH1Khz76u9orTjaJzDe4=
Date: Wed, 25 Jan 2006 12:26:19 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Mark ppc_htab_operations as const
Message-ID: <20060125092619.GB15301@mipter.zuzino.mipt.ru>
References: <20060124232406.50abccd1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ppc/kernel/ppc_htab.c:55: error conflicting types for 'ppc_htab_operations'

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Moving ppc event horizon on l4x.org/k/ further.

 arch/ppc/kernel/ppc_htab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/ppc/kernel/ppc_htab.c
+++ b/arch/ppc/kernel/ppc_htab.c
@@ -52,7 +52,7 @@ static int ppc_htab_open(struct inode *i
 	return single_open(file, ppc_htab_show, NULL);
 }
 
-struct file_operations ppc_htab_operations = {
+const struct file_operations ppc_htab_operations = {
 	.open		= ppc_htab_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,

