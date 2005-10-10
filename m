Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVJJOfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVJJOfG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVJJOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:35:06 -0400
Received: from qproxy.gmail.com ([72.14.204.194]:13884 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbVJJOfE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:35:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tz04Exv37PmKogArt9DNE2oHN/K77pQtB7Vgi9AS6DJmVo6K4ZW+ptqQ4YViXkpZBqZfQURlv0Xu0MN9ZBjKQlGbFXNEwajY3aAWi5Dm1spkumCSZD0ZMoHfbGRKqSYWJOSBQvlaju4VswZ6wJuIywoxTKCu7knsqT9e++ZwdgA=
Message-ID: <9a8748490510100735k3cabd1csdc2aa332f70f43d5@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:35:03 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] mm - implement swap prefetching
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
In-Reply-To: <200510110023.02426.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510110023.02426.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Con Kolivas <kernel@kolivas.org> wrote:
> Andrew could you please consider this for -mm
>
> Small changes to the style after suggestions from Pekka Enberg (thanks), and
> changed the default size of prefetch to gently increase with size of ram.
> Functionally this is the same code as vm-swap_prefetch-15 and I believe ready
> for a wider audience.
>

+	  What this will do on workstations is slowly bring back applications
+	  that have swapped out after memory intensive workloads back into
+	  physical ram if you have free ram at a later stage and the machine
+	  is relatively idle. This means that when you come back to your
+	  computer after leaving it idle for a while, applications will come
+	  to life faster. Note that your swap usage will appear to increase
+	  but these are cached pages, can be dropped freely by the vm, and it
+	  should stabilise around 50% swap usage.
+	
+	  Desktop users will most likely want to say Y.

How about a little note about the impact for server users as well?
You recommend that desktop users enable this, but you don't give any
recommendation for servers.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
