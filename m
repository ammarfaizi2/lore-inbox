Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFDATs>; Mon, 3 Jun 2002 20:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315975AbSFDATr>; Mon, 3 Jun 2002 20:19:47 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39175 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315946AbSFDATr>;
	Mon, 3 Jun 2002 20:19:47 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thomas Duffy <tduffy@directvinternet.com>
Cc: Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, release 3.0 is available 
In-Reply-To: Your message of "03 Jun 2002 12:22:18 MST."
             <1023132138.25501.6.camel@tduffy-lnx.afara.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Jun 2002 10:19:34 +1000
Message-ID: <7791.1023149974@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Jun 2002 12:22:18 -0700, 
Thomas Duffy <tduffy@directvinternet.com> wrote:
>I get this error now on sparc64:
>
>tduffy@curie:/build2/tduffy/linux_kbuild$ make -f Makefile-2.5 oldconfig
>Using ARCH='sparc64' AS='as' LD='ld' CC='sparc64-linux-gcc' CPP='sparc64-linux-gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
>Generating global Makefile
>  phase 1 (find all inputs)
>make: *** [phase1] Error 139

Index: 18.85/scripts/pp_db.c
--- 18.85/scripts/pp_db.c Fri, 31 May 2002 17:20:09 +1000 kaos (linux-2.4/T/f/42_pp_db.c 1.17 644)
+++ 18.85(w)/scripts/pp_db.c Tue, 04 Jun 2002 10:17:10 +1000 kaos (linux-2.4/T/f/42_pp_db.c 1.17 644)
@@ -305,7 +305,7 @@ ppdb_free_space(PPDB * db, int size)
 	}
 	oldmap = db->header;
 	ppdb_close(db);
-	if (munmap(db->header, oldsize)) {
+	if (munmap(oldmap, oldsize)) {
 		fprintf(stderr, "%s: munmap(%s) failed: %m\n", program,
 			ppdb_name);
 		abort();

The previous coding error will have corrupted the database so rm .tmp_db_main.

