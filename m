Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWIJQs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWIJQs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 12:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIJQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 12:48:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:26346 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932304AbWIJQs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 12:48:26 -0400
Message-ID: <45044169.8000609@web.de>
Date: Sun, 10 Sep 2006 18:46:33 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc6] [resend] Documentation/ABI: devfs is not obsolete,
 but removed!
References: <4502F7A9.70200@web.de> <45030245.9080005@tls.msk.ru> <20060909220230.GA19539@suse.de> <4503C807.5040403@tls.msk.ru>
In-Reply-To: <4503C807.5040403@tls.msk.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Michael Tokarev wrote at 09/10/2006 10:08 AM:

> Greg KH wrote:
>> On Sat, Sep 09, 2006 at 10:04:53PM +0400, Michael Tokarev wrote:
>>> jens m. noedler wrote:
>>>> Hi everybody, Greg, Linus,
>>>>
>>>> This little patch just moves the devfs entry from ABI/obsolete to
>>>> ABI/removed and adds the comment, that devfs was removed in 2.6.18.
>>>>
>>> []
>>>> +	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
>>>> +	along with the the assorted devfs function calls throughout the
>>>> +	kernel tree.
>>> So, will the files be removed at some point, or has them been removed
>>> already? :)
>> They are already removed.
> 
> I know they're gone. I was just pointing out that the patch is wrong,
> as it claims the files *will* be removed.

OK. I replaced "will be removed" with "were removed". And here is an 
updated patch against linus' current git tree.

Kind regards, Jens


Signed-off-by: jens m. noedler <noedler@web.de>

---

diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/obsolete/devfs
deleted file mode 100644
index b8b8739..0000000
--- a/Documentation/ABI/obsolete/devfs
+++ /dev/null
@@ -1,13 +0,0 @@
-What:		devfs
-Date:		July 2005
-Contact:	Greg Kroah-Hartman <gregkh@suse.de>
-Description:
-	devfs has been unmaintained for a number of years, has unfixable
-	races, contains a naming policy within the kernel that is
-	against the LSB, and can be replaced by using udev.
-	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
-	along with the the assorted devfs function calls throughout the
-	kernel tree.
-
-Users:
-
diff --git a/Documentation/ABI/removed/devfs b/Documentation/ABI/removed/devfs
new file mode 100644
index 0000000..8195c4e
--- /dev/null
+++ b/Documentation/ABI/removed/devfs
@@ -0,0 +1,12 @@
+What:		devfs
+Date:		July 2005 (scheduled), finally removed in kernel v2.6.18
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h were removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:


-- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de
