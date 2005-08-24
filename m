Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVHXTG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVHXTG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 15:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVHXTG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 15:06:28 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:56182 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751404AbVHXTG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 15:06:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=e0OZ+kctn+Lf2SWuwbgrqUiOFbIFxYo1K6+aHZYGF3QVq9vWDo7iLAabLl0jvdIKTidwHHPIvy3gLBZsbqfXiNlzL1P0JVLHR8xrjWSILmrrkGuZKegKk2RFWB9AnTSzMgREweLoMc/wf7PqZRXQEa4ftEvOlPlJEBYSKowz044=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] exterminate strtok
Date: Wed, 24 Aug 2005 21:06:06 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242106.06123.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 1999 Ingo Oeser commented in lib/string.c :
   * -  Added strsep() which will replace strtok() soon (because strsep() is
   *    reentrant and should be faster). Use only strsep() in new code, please.
Then in 2002 strtok was removed.

There are still a few cases of strtok in the kernel to this day. The following
3 patches exterminates them.

Let me say up front that the first two patches have *not* been tested since I 
lack both the appropriate hardware and suitable cross compiler. They are fairly 
simple though, so I doubt they'll be troublesome, but I'd greatly appreciate if
someone else would validate them and sign off on them before I send them on to 
Andrew for inclusion in -mm.  The third patch /has/ seen limited testing, but it
would still be nice to have someone look it over and sign off on it.


-- 
Jesper Juhl <jesper.juhl@gmail.com>



