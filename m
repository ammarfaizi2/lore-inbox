Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271159AbTHRBTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 21:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271174AbTHRBTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 21:19:20 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:57551 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S271159AbTHRBTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 21:19:19 -0400
Message-ID: <41036.203.17.68.210.1061169555.squirrel@secure.goldweb.com.au>
Date: Mon, 18 Aug 2003 11:19:15 +1000 (EST)
Subject: Re: [PATCH] Re: make htmldocs is broken.
From: "Michael Still" <mikal@stillhq.com>
To: <rob@landley.net>
In-Reply-To: <200308172046.22362.rob@landley.net>
References: <200308170618.35939.rob@landley.net>
        <3F3FEEAF.2070608@pobox.com>
        <200308172046.22362.rob@landley.net>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>, <mikal@stillhq.com>
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>>Working on:
>>/home/landley/linux/linux-2.6.0-test3/Documentation/DocBook/sis900.sgml
>>Done.
>>  DOCPROC Documentation/DocBook/kernel-api.sgml
>>docproc: kernel/pm.c: No such file or directory
>>make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 139
>>make: *** [htmldocs] Error 2
>
> Possibly due to me upgrading to test3-bk5.  The following patch seems
> to fix it, although there are 8 zillion warnings build everything from
> there on down...
>
> --- temp/Documentation/DocBook/kernel-api.tmpl  2003-08-17
> 20:40:39.000000000 -0400 +++
> linux-2.6.0-test3/Documentation/DocBook/kernel-api.tmpl     2003-08-17
> 20:40:54.000000000 -0400 @@ -206,7 +206,7 @@
>
>   <chapter id="pmfuncs">
>      <title>Power Management</title>
> -!Ekernel/pm.c
> +!Ekernel/power/pm.c
>   </chapter>
>
>   <chapter id="blkdev">

This patch looks good to me (it works on 2.6.0-test3-bk5). It actually
fixes  a breakage in make sgmldocs which is used by htmldocs et al.
Cheers,
Mikal


