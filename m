Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbQKMKpZ>; Mon, 13 Nov 2000 05:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129481AbQKMKpQ>; Mon, 13 Nov 2000 05:45:16 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:62736 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129193AbQKMKpK>;
	Mon, 13 Nov 2000 05:45:10 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jasper Spaans <jasper@spaans.ds9a.nl>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11pre2-ac1 and previous problem 
In-Reply-To: Your message of "Mon, 13 Nov 2000 09:58:17 BST."
             <20001113095816.A29077@spaans.ds9a.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 21:44:59 +1100
Message-ID: <2002.974112299@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2000 09:58:17 +0100, 
Jasper Spaans <jasper@spaans.ds9a.nl> wrote:
>All right, here's another one, this time using the oops directly from the
>console -- this seems to give better symbols.. The 'console shuts up ...'
>works, the oops from the other CPU didn't get put out.

Ohhhh, damn!  For NMI lockups we want the console to stay live so NMI
detection on the other cpus can be printed.  NMI is normally caused by
spinlock problems and it is useful to know what the other cpus are
doing.  Andrew, do you want to have a go at fixing this?

>Will try test11-pre3 + kdb this afternoon, if it compiles.

Patch kdb-v1.5-2.4.0-test11-pre3.gz should be OK.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
