Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQJ3SSF>; Mon, 30 Oct 2000 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbQJ3SRz>; Mon, 30 Oct 2000 13:17:55 -0500
Received: from zeus.kernel.org ([209.10.41.242]:20745 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129450AbQJ3SRl>;
	Mon, 30 Oct 2000 13:17:41 -0500
From: joeja@mindspring.com
Date: Mon, 30 Oct 2000 13:17:03 -0500
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: /proc & xml data
Message-ID: <Springmail.105.972929823.0.26378900@springmail.com>
X-Originating-IP: 206.132.209.113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um, I'd have to say that putting one value in a file with a directory as a grouping would probably be a nightmare to maintain as well as navigate through.  In essance you could end up with more files in the /proc than on the rest of the filesystem filesystem (excluding the /dev dir). It would start to have the whole proc tree look like something from /proc/sys/net/ipv4.  Although the  /proc/sys/net/ipv4 probably needs to have one value in a file as some of these are settable on from the console, other fiels that are not changable (like /proc/meminfo, proc/cpuinfo etc) would be a waste in one value per file.  

Isn't the /proc supposed to be a 'friendly' interface into the kernel?

Anyway it was a more of a question.  

>  I
> was wondering if anyone had ever considered storing some of the data in
> xml format rather than its current format?  Things like /proc/meminfo
> and cpuinfo may work good in this format as then it would be easy to
> write a generic xml parser that could then be used to parse any of the
> data. "MemTotal:  %8lu kB\n"
> 
> In the case of the meminfo it would be a matter of changing the lines in
> fs/proc/array.c  function get_meminfo(char * buffer) from
> 
> "MemTotal:  %8lu kB\n"
> 
> to something like
> 
> "%8lu kB\n"

The general consensus is that if we have a major reorganization, in proc
the rule will be one value per file.  And let directories do the grouping.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
