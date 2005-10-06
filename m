Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVJFVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVJFVcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVJFVcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:32:15 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:31400 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750941AbVJFVcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:32:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=OttNGykMA8u170yO+0PFzmo3v4zK8cLm11YIPdxLwmS5dP6LOvSe5kwaukJWP8pWN53k1JfaWXKpQy2fAvU51M5SzC0+2a/CRTFKFH/KRCYZiU1JMiqMjPEOgi9kAeBorhFBbPxw/OIfIfZlHW8Ccu4oGVzLbh6JDMk0LIYGREg=
Date: Fri, 7 Oct 2005 01:43:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] radio-cadet: check request_region() return value correctly
Message-ID: <20051006214339.GB2370@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/radio/radio-cadet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- ./drivers/media/radio/radio-cadet.c
+++ ./drivers/media/radio/radio-cadet.c
@@ -543,7 +543,7 @@ static int cadet_probe(void)
 
 	for(i=0;i<8;i++) {
 	        io=iovals[i];
-	        if(request_region(io,2, "cadet-probe")>=0) {
+	        if(request_region(io,2, "cadet-probe")) {
 		        cadet_setfreq(1410);
 			if(cadet_getfreq()==1410) {
 				release_region(io, 2);


