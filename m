Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSFDA30>; Mon, 3 Jun 2002 20:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316023AbSFDA3Z>; Mon, 3 Jun 2002 20:29:25 -0400
Received: from mx1.afara.com ([63.113.218.20]:50527 "EHLO afara-gw.afara.com")
	by vger.kernel.org with ESMTP id <S315993AbSFDA3Y>;
	Mon, 3 Jun 2002 20:29:24 -0400
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, release 3.0 is
	available
From: Thomas Duffy <tduffy@directvinternet.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Kbuild Devel <kbuild-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7791.1023149974@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jun 2002 17:29:02 -0700
Message-Id: <1023150542.25496.18.camel@tduffy-lnx.afara.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 04 Jun 2002 00:29:20.0238 (UTC) FILETIME=[DE3100E0:01C20B5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 17:19, Keith Owens wrote:

> Index: 18.85/scripts/pp_db.c
> --- 18.85/scripts/pp_db.c Fri, 31 May 2002 17:20:09 +1000 kaos (linux-2.4/T/f/42_pp_db.c 1.17 644)
> +++ 18.85(w)/scripts/pp_db.c Tue, 04 Jun 2002 10:17:10 +1000 kaos (linux-2.4/T/f/42_pp_db.c 1.17 644)
> @@ -305,7 +305,7 @@ ppdb_free_space(PPDB * db, int size)
>  	}
>  	oldmap = db->header;
>  	ppdb_close(db);
> -	if (munmap(db->header, oldsize)) {
> +	if (munmap(oldmap, oldsize)) {
>  		fprintf(stderr, "%s: munmap(%s) failed: %m\n", program,
>  			ppdb_name);
>  		abort();
> 
> The previous coding error will have corrupted the database so rm .tmp_db_main.

awesome.  that fixes the problem.  thanks.

-tduffy

