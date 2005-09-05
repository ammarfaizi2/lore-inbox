Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVIEQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVIEQgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVIEQgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:36:19 -0400
Received: from hera.kernel.org ([209.128.68.125]:37074 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932332AbVIEQgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:36:18 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Mon, 5 Sep 2005 16:35:42 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <dfhs4u$1ld$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125938142 1710 127.0.0.1 (5 Sep 2005 16:35:42 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 5 Sep 2005 16:35:42 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
By author:    Kyle Moffett <mrmacman_g4@mac.com>
In newsgroup: linux.dev.kernel
> 
> Didn't you mean "#define stat __kabi_stat64"?  Also, I can see that
> would pose other issues as well say my app does "struct stat stat;"
> Any error messages would refer to a variable "__kabi_stat64" instead
> of the expected "stat":
> 

No, I didn't.  That's *exactly* why I didn't mean that.

#define __kabi_stat64 stat
#include <linux/abi/stat.h>

That being said, I would personally like to see it possible to typedef
struct, union and enum tags.

	-hpa
