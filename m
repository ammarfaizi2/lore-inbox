Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVJSPbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVJSPbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJSPbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:31:45 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:34891 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751077AbVJSPbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:31:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hRnxgk3c+s+70x2mmYODVretFoNkZhqeUkMQn2jdCZiJn+JFOUO0vVvgLu8STRBb1oUKyOCJYY79Lydr2VFpOaSjEpEP+2LkjORQ23vtwA+KMYQWHqwvzJrJinyNzx+2ULFUgXVfsea38MiMfsg2J451yK112YztvvwakT/gYEM=
Message-ID: <4ae3c140510190831j7530742aqc2b82e9e9cd6dde3@mail.gmail.com>
Date: Wed, 19 Oct 2005 11:31:44 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is ext3 flush data to disk when files are closed?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I know, if an application modifies a file on an ext3 file
ssytem, it actually change the page cache, and the dirty pages will be
flushed to disk by kupdate periodically.

My question is: if a file is to be closed, but some of its data pages
are marked as dirty, will system block on close() and wait for dirty
pages being flushed to disk? If so, it seems to decrease performance
significantly if a lot of updates on many small files are involved.

Can someone point me to the right place to check how it works? Thanks!

Xin
