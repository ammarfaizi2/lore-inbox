Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbVKCVeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbVKCVeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVKCVeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:34:44 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:41569 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030500AbVKCVen convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:34:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CEiGk0D9YjRQoyiQUmiEHwLMn5oi2hZD3fUpvwVfzEtKzc1orSo2Bk6SB5c0jWHF/LTwPaUmD/q65DnJNNUBGQogYTssngUNma8smpg+GIklm9JLYnkbYrf96bAZTaPYI4s0EG/B5HKYWlF1WkI1MvTK2lqJP3ZtlKbJKP1VisM=
Message-ID: <afcef88a0511031334t5bd8056ci1028591eabbd4e@mail.gmail.com>
Date: Thu, 3 Nov 2005 15:34:41 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/12: eCryptfs] Main module functions
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <20051103060236.GB5044@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103034929.GD3005@sshock.rn.byu.edu>
	 <20051103060236.GB5044@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 02, 2005 at 08:49:29PM -0700, Phillip Hellewell wrote:
> > +#include <net/sock.h>
> > +#include <linux/file.h>
>
> net/ after linux/ please.  Why do you need sock.h anyway?

Here is the followup patch to remove the sock and include dcache.h.

Other patches will follow to resolve other comments.

Thanks,
Mike

-----

Signed off by: Michael Thompson <mmcthomps@us.ibm.com>

--- linux-2.6.14-rc2/fs/ecryptfs/main.c 2005-11-03 15:25:19.000000000 -0600
+++ linux-ecryptfs-updated/fs/ecryptfs/main.c   2005-11-03
15:26:56.000000000 -0600
@@ -26,7 +26,7 @@
 #ifdef HAVE_CONFIG_H
 # include <config.h>
 #endif                         /* HAVE_CONFIG_H */
-#include <net/sock.h>
+#include <linux/dcache.h>
 #include <linux/file.h>
 #include <linux/module.h>
 #include <linux/namei.h>
