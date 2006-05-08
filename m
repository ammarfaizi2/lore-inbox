Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWEHDNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWEHDNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 23:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWEHDNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 23:13:25 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:10226 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932266AbWEHDNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 23:13:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=e0sYVtM1fxp5KWkrNR21aCoZzrQlopD+dwDPS06u1+KqePdpoOKjzvH/8BpBnLekg+JGWasM7fEdk4MP19d//rg9pcI6Hi7xA4OWz7efAQsgegWAjceGRXhWlO6OBiE372SDmS8VBu/jpJqieK1extGTWq4UMgDg7R7Qgx0J9jA=
Message-ID: <cc723f590605072013v67e89b7wf8446a55e3927480@mail.gmail.com>
Date: Mon, 8 May 2006 08:43:23 +0530
From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typos in Documentation/memory-barriers.txt
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_122790_2949045.1147058003780"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_122790_2949045.1147058003780
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Fix some typos in Documentation/memory-barriers.txt

 Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

------=_Part_122790_2949045.1147058003780
Content-Type: text/x-patch; name=memory-barriers.txt.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_emy8mh9c
Content-Disposition: attachment; filename="memory-barriers.txt.diff"

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 92f0056..c61d8b8 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1031,7 +1031,7 @@ conflict on any particular lock.
 LOCKS VS MEMORY ACCESSES
 ------------------------
 
-Consider the following: the system has a pair of spinlocks (N) and (Q), and
+Consider the following: the system has a pair of spinlocks (M) and (Q), and
 three CPUs; then should the following sequence of events occur:
 
 	CPU 1				CPU 2
@@ -1678,7 +1678,7 @@ CPU's caches by some other cache event:
 	smp_wmb();
 	<A:modify v=2>	<C:busy>
 			<C:queue v=2>
-	p = &b;		q = p;
+	p = &v;		q = p;
 			<D:request p>
 	<B:modify p=&v>	<D:commit p=&v>
 		  	<D:read p>


------=_Part_122790_2949045.1147058003780--
