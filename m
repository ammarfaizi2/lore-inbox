Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbULUCQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbULUCQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbULUCQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:16:04 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:58309 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261179AbULUCQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:16:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Eo09sdmgJM8G6atNIPu7EHKnevNDroVh9Vyt86Ua2ERW1s5zzfu+86sJL7KiKweFnU5ruJijh4eqiUVXpgYuO7aU6mFtYi8zdgLnACBKyPjHJ7WTlrM+dWMtIBS823DfkuFpF1yD0hNLqNvGNI3yLQS4tovCKjw2vKMbDRVB/Mg=
Message-ID: <f537fb070412201816662ca65d@mail.gmail.com>
Date: Mon, 20 Dec 2004 18:16:01 -0800
From: Julian Pellico <jpellico@gmail.com>
Reply-To: Julian Pellico <jpellico@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: bug in smbfs source code?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been looking over the smbfs kernel code with someone at work and
he thinks there might be a bug.

In fs/smbfs/proc.c function smb_build_path (I won't give exact line
numbers 'cause I'm looking at 2.5.6), the first call of the form:

len = server->ops->convert(path, maxlen-2, 
				      entry->d_name.name, entry->d_name.len,
				      server->local_nls, server->remote_nls);

We think that maxlen-2 should be
maxlen - (2 << unicode)

Does anyone agree?

Thanks,
Julian
