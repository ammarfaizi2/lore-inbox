Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWHJFE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWHJFE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWHJFE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:04:29 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:8376 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161029AbWHJFE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:04:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O7gLJroHQxCYLdBL1xmOHMG/W2D70svYwY2vVTfZNMuHRQ1bay/RIr7su/gHfVC+8KclPqBUCss1evHDEuW1kswL48KzdKFae8pOCcVKOzrU5KZvm7QKHK3+tcfIwJ15nzWndHvZlyu95EXHV3Yj7UbvbmCTRWLL46RDKTU+cqQ=
Message-ID: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
Date: Thu, 10 Aug 2006 01:04:27 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Urgent help needed on an NFS question, please help!!!
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just ran into a problem about NFS. It might be a fundmental problem
of my current work. So please help!

I am wondering how NFS guarantees a client didn't get wrong file
attributes. Consider the following scenario:

Suppose we have an NFS server S and two clients C1 and C2.

Now C1 needs to access the file attributes of file X, it first does
lookup() to get the file handle of file X.

After C1 gets X's file handle and before C1 issues the getattr()
request, C2 cuts in. Now C2 deletes file X and creates a new file X1,
which has different name but the same inode number and device ID as
the nonexistent file X.

When C1 issues getattr() with the old file handle, it may get file
attribute on wrong file X1. Is this true?

If not, how NFS avoid this problem? Please direct me to the code that
verifies this.

Many many thanks!

-x
