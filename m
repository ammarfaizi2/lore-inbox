Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTIQOHr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 10:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbTIQOHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 10:07:47 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:51391 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S262763AbTIQOHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 10:07:19 -0400
Message-ID: <3F686AEF.1000900@basmevissen.nl>
Date: Wed, 17 Sep 2003 16:08:47 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jarausch@belgacom.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14-pre7 Unresolved symbols
References: <20030917095232.CC86AA7E68@numa-i.igpm.rwth-aachen.de>
In-Reply-To: <20030917095232.CC86AA7E68@numa-i.igpm.rwth-aachen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jarausch@belgacom.net wrote:
> Hi,
> 
> trying to build 2.4.14-pre7 breaks with the error message
> depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
> depmod:         unlock_page
> 
> during make modules_install.
> 
> 2.4.14-pre6 is running fine here.
> 

Why are you (still) using 2.4.14-preX? Current stable version is 2.4.22 
and 2.4.23-preX is under development.

Anyway, grep for "unlock_page" in all .c files, find out if the .o of it 
is built and if the symbol is exported with EXPORT_SYMBOL.

BTW. Did you save the .config file and ran "make mrproper" before 
building? It is very likely that after patching up in a "used" tree, the 
rebuild is not going entirely correctly.

Regards,

Bas.


