Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVGYREF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGYREF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVGYREF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:04:05 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:48217 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbVGYRD7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:03:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=oqtaSW0Ppbp3E6t3dtQQo76bbvF59/6SX+9tOt6xi4aguDvbtXV1+KpfoLTqVf8f3JBpWDA/JeVSHAHd1dXfdp+KVVwm/JNIlwDj2OGzbFDTzPDA//jlzqYZios2/Ui0rb4g4mvqKvflIWGSK3t4Z+3ngXWSlBRcZGq7BJ233wg=
Date: Mon, 25 Jul 2005 19:03:27 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: Kernel cached memory
Message-Id: <20050725190327.0302f5f8.diegocg@gmail.com>
In-Reply-To: <42E517B6.1010704@tmr.com>
References: <003401c58ea2$4dfd76f0$5601010a@ashley>
	<20050722132523.GJ20995@vega.lgb.hu>
	<42E517B6.1010704@tmr.com>
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 25 Jul 2005 12:47:50 -0400,
Bill Davidsen <davidsen@tmr.com> escribió:

> Just because default operation works well for you, kindly don't try to 
> convice us that there are no cases when the default operation is NOT 
> optimal. And IMHO Linux is *way* too willing to evicy clean pages of my 
> programs to use as disk buffer, so that when system memory is full I pay 
> the overhead of TWO disk i/o's, one to finally write the data to the 
> disk and one to read my program back in. If free software is about 
> choice, I wish there was more in the area of how memory is used.

You must be more specific here; cached memory isn't always dirty. Most
of the times the pages used for cache are clean and can be evicted
quite fast and of course without writting anything to the disk.

If you want to tune the balance between "pages used for programs" vs
"pages used for cache" that's another problem, but I can't find a
reason why kernel shouldn't cache things when free memory is
available. And certainly that's not what Ashley was asking.
