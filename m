Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTKKEDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKKEDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:03:17 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:9376 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264254AbTKKEDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:03:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 20:03:15 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: jw schultz <jw@pegasys.ws>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031111034815.GA17240@pegasys.ws>
Message-ID: <Pine.LNX.4.44.0311102002090.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, jw schultz wrote:

> If the history file (or another single file) is enough:
> 
>         starthist=`ls -l $CVSROOT/CVSROOT/history`
>         curhist=""
> 
>         while [ "$Starthist" != "$curhist" ]
>         do
> 		starthist=`ls -l $CVSROOT/CVSROOT/history`
>                 rsync .....
>                 curhist=`ls -l $CVSROOT/CVSROOT/history`
>         done

BK2CVS does not compile $CVSROOT/CVSROOT/history, but the second one 
should work:

> If not you can test the directory.
> 
>         ls -l $CVSROOT/CVSROOT >$TMPFILE.start
>         touch $TMPFILE.test
> 
>         until diff -q $TMPFILE.start $TMPFILE.test >/dev/null
>         do
> 		ls -l $CVSROOT/CVSROOT >$TMPFILE.start
>                 rsync .....
>                 ls -l $CVSROOT/CVSROOT >$TMPFILE.test
>         done
>         rm -f $TMPFILE.start $TMPFILE.test



- Davide


