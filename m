Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWBAMgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWBAMgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWBAMgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:36:45 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:21454 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932431AbWBAMgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:36:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=QwTeL6u3/mboT4i+Kb5+hn7rIk6BnUaofR9XQ55ucU7bmg5kaCFhHpfyxlk2HLSFnXr2cCdpIh4ucx+nlUOLZrMLC5Na1ANsDyhGikx1LPI9GFQNNwiTxnaXNlVDgOvBpjf9YUQ9cvoySE4YFBkWAVq9D6zxtBerRaNNptPXnkk=
Date: Wed, 1 Feb 2006 15:54:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] extract-ikconfig: use mktemp(1)
Message-ID: <20060201125435.GA8943@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/extract-ikconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/extract-ikconfig
+++ b/scripts/extract-ikconfig
@@ -45,7 +46,7 @@ then
 	exit 1
 fi
 
-TMPFILE="/tmp/ikconfig-$$"
+TMPFILE=`mktemp -t ikconfig-XXXXXX` || exit 1
 image="$1"
 
 # vmlinux: Attempt to dump the configuration from the file directly

