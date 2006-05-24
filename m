Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWEXEbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWEXEbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWEXEbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:31:36 -0400
Received: from main.gmane.org ([80.91.229.2]:31701 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932566AbWEXEbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:31:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: charset2upper broken
Date: Wed, 24 May 2006 10:31:24 +0600
Message-ID: <e50nie$3ud$1@sea.gmane.org>
References: <44722ACE.3040500@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.220.94.150
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
In-Reply-To: <44722ACE.3040500@austin.rr.com>
Cc: linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> Charset2upper is broken, at least for utf8 (see line 41 of nls_utf8.c)   
> Seems straightforward to fix it for the key characters a-z (0x61-0x7a), 
> unless the uppercasing rules are stranger than I think - especially 
> since other places have it right e.g. nls_base.c seems to have it right 
> in its charset2upper.

<troll>
Don't use UTF-8. Neither the kernel nor userspace is fully ready.

Also, it seems wrong to put such comples thing as a complete UNICODE upper/lower 
case mapping into the kernel, especially since this mapping is different for 
Turkish and non-Turkish cases (see 
http://www.i18nguy.com/unicode/turkish-i18n.html). So someone should convert all 
filesystems that use character conversion and case mapping to FUSE, so that they 
can use glibc to do all of this dirty/complex work.
</troll>

-- 
Alexander E. Patrakov

