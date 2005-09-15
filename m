Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbVIOPfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbVIOPfC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 11:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVIOPfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 11:35:01 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:23914 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030493AbVIOPfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 11:35:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NvNAo94ZKFU/ajMTSQzXIgzIIwpBB4E4oJJ+aNFv5ohbn5gjnUgmaLLFzoIrH4xe582+mpbS7eG0jNT7j6oDv1wfHdC1RovDJGtdGx3FMtw7uNpig+vYy6kbUSfNP12//tveEUwEaNnl0y8ehrpHwK5v5R186g0UPgG2/f7mk1Q=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH] 2.6.13-mm3 ort v.b6 (OOPS Reporting Tool), try2
Date: Thu, 15 Sep 2005 17:36:34 +0200
User-Agent: KMail/1.8.2
Cc: Cal Peake <cp@absolutedigital.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paolo.ciarrocchi@gmail.com,
       rdunlap@xenotime.net, Paul TT <paultt@bilug.linux.it>
References: <43276366.80304@gmail.com> <Pine.LNX.4.61.0509140436090.4846@lancer.cnet.absolutedigital.net> <4327FD7B.1040300@bilug.linux.it>
In-Reply-To: <4327FD7B.1040300@bilug.linux.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509151736.35050.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 12:37, Paul TT wrote:
> Cal Peake wrote:
> 
> >On Wed, 14 Sep 2005, Michal Piotrowski wrote:
> >
> >  
> >
> >>Hi Andrew,
> >>I think, that this maybe useful for oops hunters :)
> >>
> >>Paolo, Paul, Randy, Jesper, Cal please sign it.
> >>
> >>Regards,
> >>Michal Piotrowski
> >>
> >>Signed-off-by: Michal K. K. Piotrowski <michal.k.k.piotrowski@gmail.com>
> >>    
> >>
> >
> >Signed-off-by: Cal Peake <cp@absolutedigital.net>
> >  
> >
> Signed-off-by: Paul TT <paultt@bilug.linux.it>
> 

Apply the small patch below on top of it, and you can add 

   Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>



--- linux-2.6.14-rc1/scripts/ort.sh.orig	2005-09-15 17:32:02.000000000 +0200
+++ linux-2.6.14-rc1/scripts/ort.sh	2005-09-15 17:33:08.000000000 +0200
@@ -98,12 +98,12 @@
 }
 
 check_which() {
-        WHICH=`which $1`
+        WHICH=`which $1 2> /dev/null`
         if [ "$WHICH" != "" ]
         then
                 echo -e " [available]"
         else
-                echo
+                echo -e " [not available]"
         fi
 }
 
@@ -859,8 +859,7 @@
 
 
 OOPS Reporting Tool $VER
-www.wsi.edu.pl/~piotrowskim/
-/files/ort/beta/
+http://www.wsi.edu.pl/~piotrowskim/files/ort/beta/
 EOF
 }
 
