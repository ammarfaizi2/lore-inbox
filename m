Return-Path: <linux-kernel-owner+w=401wt.eu-S1947422AbWLHWDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947422AbWLHWDs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947423AbWLHWDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:03:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36816 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947422AbWLHWDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:03:48 -0500
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
From: Arjan van de Ven <arjan@infradead.org>
To: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4579ADE3.6040609@tungstengraphics.com>
References: <4579ADE3.6040609@tungstengraphics.com>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Fri, 08 Dec 2006 23:03:36 +0100
Message-Id: <1165615416.27217.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 19:24 +0100, Thomas Hellström wrote:
> 
> +void agp_generic_free_user(struct agp_memory *curr)
> +{
> +       if ((unsigned long) curr->memory >= VMALLOC_START 
> +           && (unsigned long) curr->memory < VMALLOC_END) {
> +               vfree(curr->memory);
> +       } else {
> +               kfree(curr->memory);
> +       }
> +       agp_free_key(curr->key);
> +       kfree(curr);


why? this really is almost too ugly to live ;(

> +}
> +EXPORT_SYMBOL(agp_generic_free_user);
> + 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

