Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133051AbRAGPCT>; Sun, 7 Jan 2001 10:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135256AbRAGPCK>; Sun, 7 Jan 2001 10:02:10 -0500
Received: from slc175.modem.xmission.com ([166.70.9.175]:53257 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S133051AbRAGPBz>; Sun, 7 Jan 2001 10:01:55 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 todo list update
In-Reply-To: <Pine.LNX.4.21.0101051244440.1295-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2001 07:51:33 -0700
In-Reply-To: Rik van Riel's message of "Fri, 5 Jan 2001 12:58:34 -0200 (BRDT)"
Message-ID: <m1n1d3ifey.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:


> The following bugs _could_ be fixed ... I'm not 100% certain
> but they're probably gone (could somebody confirm/deny?):
> 
> * mm->rss is modified in some places without holding the
>   page_table_lock

As of linux-2.4.0-test13-pre7 I can confirm that this bug
still exists.  The most obvious  location is in zap_page_range,
there may be others as well.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
