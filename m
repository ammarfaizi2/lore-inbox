Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWBYRb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWBYRb1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWBYRb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:31:27 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:19470 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932593AbWBYRb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:31:26 -0500
Message-ID: <440093C6.4000904@vmware.com>
Date: Sat, 25 Feb 2006 09:28:38 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ak@suse.de,
       dhecht@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] Fix topology.c location
References: <200602242305.k1ON5Tmb026520@hera.kernel.org> <20060225085538.GA17448@redhat.com>
In-Reply-To: <20060225085538.GA17448@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>This change breaks x86-64 compiles, as it uses the same file.
>  
>

Thanks for fixing that.  Have we decided that file sharing of this sort 
is a really bad idea yet?  I still see early_printk and  pci-direct.h 
sharing remains.  If this sharing really must go on, isn't there a less 
ad-hoc way to do it?  Or at least a mention in the file that "before you 
modify, note this is shared by arch foo".

Zach
