Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSCCWhx>; Sun, 3 Mar 2002 17:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCCWhn>; Sun, 3 Mar 2002 17:37:43 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:19981 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S289880AbSCCWha>;
	Sun, 3 Mar 2002 17:37:30 -0500
Date: Sun, 3 Mar 2002 22:37:26 +0000
From: John Levon <levon@movementarian.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [levon@movementarian.org: [PATCH] define KBUILD_BASENAME for .i .s]
Message-ID: <20020303223726.GA18544@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Keith Owens has OK'd this minor cleanup

thanks
john

--qDbXVdCdHGoSgWSk
Content-Type: message/rfc822
Content-Disposition: inline

Date: Sun, 3 Mar 2002 16:44:06 +0000
From: John Levon <levon@movementarian.org>
To: kaos@ocs.com.au
Subject: [PATCH] define KBUILD_BASENAME for .i .s
Message-ID: <20020303164406.GA10307@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A


Probably this really doesn't matter but ...

against 2.4.18

regards
john

--- Rules.make.old      Thu Dec 31 18:05:20 1987
+++ Rules.make  Thu Dec 31 18:05:59 1987
@@ -50,10 +50,10 @@
 #
 
 %.s: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) -S $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -S $< -o $@
 
 %.i: %.c
-	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@
+	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) $< > $@
 
 %.o: %.c
	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) $(CFLAGS_$@) -c -o $@ $<


-- 
I am a complete moron for forgetting about endianness. May I be
forever marked as such.

--qDbXVdCdHGoSgWSk--
