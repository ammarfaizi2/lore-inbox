Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWEXLxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWEXLxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWEXLxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:53:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:19424 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932283AbWEXLxS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:53:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+8cJDzfGQ56cdmyeJSW3ixCI4DgQfEknBHM86IBX//duPNRlGgzrslx1y/8cwwK7WDzjmoSpLF4pG7gKNlk/jB8iy7IUKNdZxR9aAnN0s5r0qN67jbtke9SgH2hYduP4YgkezpcPeZk8RxVEE9QFAMJW2xUrC1IN4yJpIqCJO0=
Message-ID: <2bc0baf20605240453l89e5cd7w949377ead93e8b66@mail.gmail.com>
Date: Wed, 24 May 2006 13:53:17 +0200
From: "German San Agustin" <chamocarrot@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 NFS client read-ahead
In-Reply-To: <2bc0baf20605240446h197b3d2fxc797404aa0e733ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2bc0baf20605240446h197b3d2fxc797404aa0e733ba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have several linux 2.6.9 accesing to a netapp filer via nfs to
update several thousands of files. The application only need to read a
few blocks of the files when updating so we found out that disabling
the read-ahead on the server improve greatly the performance by
maintaining a clean cache and decreasing the number of access to disk.
We have been trying to disable the read-ahead in the client as well to
reduce the access to the server even further; but we couldn't find
 where to do this in the 2.6 kernel family. Is it possible?, or it is
simply that on 2.6 kernels it is not possible to tune the nfs client.
